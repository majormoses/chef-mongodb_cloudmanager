require 'spec_helper'

describe 'ensure thp is disabled' do
  # we want to make sure that any values passed in as
  # node['elasticsearch'][ROLE_NAME]['custom_config'] = {}
  # are properly merged into config
  describe file('/sys/kernel/mm/transparent_hugepage/enabled') do
    it { should be_file }
    its(:content) { should match(/always madvise \[never\]/) }
  end
end
