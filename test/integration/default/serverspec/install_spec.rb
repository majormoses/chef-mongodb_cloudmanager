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
  # the service should run
  it 'should enable and start the mongodb-mms-automation-agent service' do
    expect(service('mongodb-mms-automation-agent')).to be_enabled
    expect(service('mongodb-mms-automation-agent')).to be_running
  end
end
