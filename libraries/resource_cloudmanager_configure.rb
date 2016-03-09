class MongodbCloudManagerCookbook::MongodbCloudManagerConfigureResource < Chef::Resource::LWRPBase
  resource_name :mongodb_cloudmanager_configure
  provides :mongodb_cloudmanager_configure

  actions :configure
  default_action :configure

  attribute(:api_key, kind_of: String, default: nil)
  attribute(:config_file, kind_of: String, default: '/etc/mongodb-mms/automation-agent.config')
  attribute(:data_dir, kind_of: String, default: nil)
  attribute(:group_id, kind_of: String, default: nil)
end
