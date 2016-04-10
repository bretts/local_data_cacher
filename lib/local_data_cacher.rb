require 'yaml'
require 'fileutils'

class LocalDataCacher
    def initialize(dir)
        @cache_dir = dir
        FileUtils.mkdir_p(@cache_dir) unless Dir.exists?(@cache_dir)
    end

    def use_cached_data?(file_name, num_days_cache_file: 7)
        if(File.exists?("#{@cache_dir}/#{file_name}"))
            if((Time.now - File.stat("#{@cache_dir}/#{file_name}").mtime).to_i / 86400.0 >= num_days_cache_file.to_f)
                return false
            else
                return true
            end
        else
            return false
        end
    end

    def load_data(file_name)
        return YAML.load_file("#{@cache_dir}/#{file_name}")
    end

    def save_data(data, file_name)
        File.open("#{@cache_dir}/#{file_name}", 'w+') do |f|
            f.puts data.to_yaml
        end
    end

    def get_cached_data_info(file_name)
        if(File.exists?("#{@cache_dir}/#{file_name}"))
            age = ((Time.now - File.stat("#{@cache_dir}/#{file_name}").mtime).to_i / 86400.0).round.to_i
            return "#{@cache_dir}/#{file_name} is currently about #{age} day(s) old"
        else
            return "#{@cache_dir}/#{file_name} does not exist"
        end
    end
end