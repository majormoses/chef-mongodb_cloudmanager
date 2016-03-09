class MongodbCloudManagerCookbook::MongodbCloudManagerInstallProvider < Chef::Provider::LWRPBase
  include MongodbCloudManagerCookbook::Helpers
  provides :mongodb_cloudmanager_install

  use_inline_resources

  action :install do
    unless new_resource.base_url
      new_resource.base_url determine_base_url(new_resource, node)
    end

    unless new_resource.file_name
      new_resource.file_name determine_filename(new_resource, node)
    end

    unless new_resource.files
      new_resource.files determine_files(new_resource, node)
    end

    sha256 = determine_checksum(new_resource)

    # download the agent
    remote_file '/tmp/' + new_resource.file_name do
      source new_resource.base_url + new_resource.file_name
      checksum sha256
    end

    # install the agent
    dpkg_package new_resource.file_name do
      action :install
      source '/tmp/' + new_resource.file_name
    end

    # edit the config

    # make the mongodb data dar
    # directory new_resource.data_dir do
    #   owner 'mongodb'
    #   group 'mongodb'
    #   mode 00755
    #   recursive true
    #   action :create
    # end

    # start the service
    # service 'mongodb-mms-automation-agent' do
    #   supports :status => true
    #   action [ :enable, :start ]
    # end
  end
end
