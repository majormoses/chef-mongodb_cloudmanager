class MongodbCloudManagerCookbook::MongodbCloudManagerConfigureProvider < Chef::Provider::LWRPBase
  include MongodbCloudManagerCookbook::Helpers
  provides :mongodb_cloudmanager_configure

  use_inline_resources

  action :configure do
    unless new_resource.data_dir
      new_resource.data_dir determine_datadir(new_resource, node)
    end

    # edit the config
    ruby_block 'edit_config' do
      block do
        unless ::File.exist?('/mms-config.done')
          file = ::File.read(new_resource.config_file)
          text = file.gsub('mmsGroupId=', "mmsGroupId=#{new_resource.group_id}")
          replaced = text.gsub('mmsApiKey=', "mmsApiKey=#{new_resource.api_key}")
          ::File.open(new_resource.config_file, 'w') { |f| f.print replaced }
          file '/mms-config.done' do
            owner 'root'
            group 'root'
            mode 00755
            action :touch
          end
        end
      end
    end

    # make the mongodb data dar
    directory new_resource.data_dir do
      owner 'mongodb'
      group 'mongodb'
      mode 00755
      recursive true
      action :create
    end

    # if we specify a disk then create an xfs volume and mount it in /data
    # however we only do it if we have not done it before (we touch a file)
    if new_resource.data_disk
      filesystem 'mongodb_data' do
        fstype 'xfs'
        device new_resource.data_disk
        mount new_resource.data_dir
        action [:create, :enable, :mount]
        not_if { ::File.exist?(new_resource.data_dir + '/disk_formatted.done') }
      end

      # touch a file to know when its not safe to format
      file new_resource.data_dir + '/disk_formatted.done' do
        owner 'root'
        group 'root'
        mode 00755
        action :touch
      end

      directory new_resource.data_dir do
        owner 'mongodb'
        group 'mongodb'
        mode 00755
        recursive true
        action :create
      end
    end

    # start the service
    service 'mongodb-mms-automation-agent' do
      supports :status => true
      action [:enable, :start]
    end
  end
end
