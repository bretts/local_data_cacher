require_relative '../spec_helper'

describe "LocalDataCacher" do

    describe '#use_cached_data?' do
        it 'should return false if the file does not exist' do
            dir = "/tmp/local_data_cacher/#{Time.now.to_i}"
            local_data_cacher = LocalDataCacher.new(dir)
            expect(local_data_cacher.use_cached_data?('i_dont_exist')).to eq(false)
        end

        it 'should return false if the file exists but its age has exceeded the cached period' do
            dir = "/tmp/local_data_cacher/#{Time.now.to_i}"
            local_data_cacher = LocalDataCacher.new(dir)
            File.open("#{dir}/i_exist", 'w+') { |f| f.puts "hello" }
            sleep 1

            expect(local_data_cacher.use_cached_data?('i_exist', num_days_cache_file: 0.00000000001)).to eq(false)
        end

        it 'should return true if the file exists and its age is still less than the the cache period' do
            dir = "/tmp/local_data_cacher/#{Time.now.to_i}"
            local_data_cacher = LocalDataCacher.new(dir)
            File.open("#{dir}/i_exist", 'w+') { |f| f.puts "hello" }

            expect(local_data_cacher.use_cached_data?('i_exist', num_days_cache_file: 7)).to eq(true)
        end
    end
end