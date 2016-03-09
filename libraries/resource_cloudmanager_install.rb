class MongodbCloudManagerCookbook::MongodbCloudManagerInstallResource < Chef::Resource::LWRPBase
  resource_name :mongodb_cloudmanager_install
  provides :mongodb_cloudmanager_install

  actions :install
  default_action :install

  attribute(:base_url, kind_of: String, default: nil)
  attribute(:file_name, kind_of: String, default: nil)
  attribute(:files, kind_of: Hash, default: nil)
end
