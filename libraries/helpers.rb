module MongodbCloudManagerCookbook
  module Helpers
    def determine_platform
      node['platform_family']
    end

    def systemd?
      IO.read('/proc/1/comm').chomp == 'systemd'
    end

    def upstart?
      File.executable?('/sbin/initctl')
    end

    def determine_base_url(new_resource, node)
      if new_resource.base_url
        new_resource.base_url.to_s
      elsif node['mongodb'] && node['mongodb']['cloud']['manager']['base_url']
        node['mongodb']['cloud']['manager']['base_url']
      else
        raise 'could not determine the base url to download mongodb agent'
      end
    end

    def determine_filename(new_resource, node)
      if new_resource.file_name
        new_resource.file_name.to_s
      elsif node['mongodb'] && node['mongodb']['cloud']['manager']['file_name']
        node['mongodb']['cloud']['manager']['file_name']
      else
        raise 'could not determine the file name to download mongodb agent'
      end
    end

    def determine_files(new_resource, node)
      if new_resource.files
        new_resource.file_name.to_h
      elsif node['mongodb'] && node['mongodb']['cloud']['manager']['files']
        node['mongodb']['cloud']['manager']['files']
      else
        raise 'could not get a hash of files with checksums'
      end
    end

    def determine_datadir(new_resource, node)
      if new_resource.data_dir
        new_resource.data_dir
      elsif node['mongodb'] && node['mongodb']['data_dir']
        node['mongodb']['data_dir']
      else
        raise 'could not determine the data dir location'
      end
    end

    def determine_checksum(new_resource)
      if new_resource.files && new_resource.file_name
        new_resource.files[new_resource.file_name].to_s
      elsif node['mongodb'] && node['mongodb']['cloud']['manager']['files'] && node['mongodb']['cloud']['manager']['file_name']
        node['mongodb']['cloud']['manager']['files'].to_h[node['mongodb']['cloud']['manager']['file_name']].to_s
      else
        raise 'could not get a checksum for the specified file'
      end
    end
  end
end
