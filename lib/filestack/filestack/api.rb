module Filestack
    class API
        extend Memoist
        FS_KEY= ENV["FS"]
        def upload_file(path)
            flink = client.upload filepath: path

        end

        private
        memoize def client
            puts "Initializing Filestack client"
            FilestackClient.new FS_KEY
        end
    end
end
