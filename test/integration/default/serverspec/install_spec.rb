require 'spec_helper'

describe package('mongodb-mms-automation-agent-manager') do
  it { should be_installed }
end

describe 'mongodb-mms-automation-agent service' do
  # it should have an init file and be executable
  describe file('/etc/init/mongodb-mms-automation-agent.conf') do
    it { should be_file }
    it { should be_mode 644 }
  end
end

describe file '/mongodb_cloudmanager_install.done' do
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
end
