class Media 
    class << self
        def trim(source_path, destination_path, width: -1, height: -1)
            puts "ffmpeg -i #{source_path} -vf scale=#{width}:#{height} #{destination_path}"
            `ffmpeg -y -loglevel warning -hide_banner -stats  -i #{source_path} -vf scale=#{width}:#{height} #{destination_path}`
        end
    end

end