# base URL
default['mongodb']['cloud']['manager']['base_url'] = 'https://cloud.mongodb.com/download/agent/automation/'
# this the file/version you want to download the naming is inconsistant
# between os versions so I am requiring the full file name to be safe
default['mongodb']['cloud']['manager']['file_name'] = 'mongodb-mms-automation-agent-manager_2.6.0.1551-1_amd64.deb'
# hash of files/versions to their sha256
default['mongodb']['cloud']['manager']['files'] = {
  'mongodb-mms-automation-agent-manager_2.6.0.1551-1_amd64.deb' => '08be726a493f5e202702b6421bbafa367629bc17599985ac2b5e346ce10760ce',
  'mongodb-mms-automation-agent-manager_2.6.0.1551-1_amd64.ubuntu1604.deb' => 'b5d585524554299079e4d636cc072ea331485a912cdf20799bef86e8b7097593'
}

default['mongodb']['data_dir'] = '/data'
