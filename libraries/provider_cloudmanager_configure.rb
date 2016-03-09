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
        file = ::File.read(new_resource.config_file)
        text = file.gsub('mmsGroupId=', "mmsGroupId=#{new_resource.group_id}")
        replaced = text.gsub('mmsApiKey=', "mmsApiKey=#{new_resource.api_key}")
        ::File.open(new_resource.config_file, 'w') { |f| f.print replaced }
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

    # start the service
    service 'mongodb-mms-automation-agent' do
      supports :status => true
      action [:enable, :start]
    end
  end
end
