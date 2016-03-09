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
      not_if { ::File.exist?('/mongodb_cloudmanager_install.done') }
    end

    # install the agent
    dpkg_package new_resource.file_name do
      action :install
      source '/tmp/' + new_resource.file_name
      not_if { ::File.exist?('/mongodb_cloudmanager_install.done') }
    end

    # make a file to lock new version install
    file '/mongodb_cloudmanager_install.done' do
      owner 'root'
      group 'root'
      mode 00755
      action :touch
    end
  end
end
