require 'spec_helper'

describe file('/mms-config.done') do
  it { should exist }
  it { should be_file }
  it { should be_mode(755) }
  it { should be_owned_by('root') }
  it { should be_grouped_into('root') }
end

describe file('/data') do
  it { should exist }
  it { should be_directory }
  it { should be_mode(755) }
  it { should be_owned_by('mongodb') }
  it { should be_grouped_into('mongodb') }
end

describe service('mongodb-mms-automation-agent') do
  it { should be_enabled }
  it { should be_running }
end
