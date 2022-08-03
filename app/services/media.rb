class Media 
    class << self
        def trim(source_path, destination_path, width: :auto, height: :auto)
            image = Rszr::Image.load(source_path)
            image.resize!(width, height)
            image.save destination_path
        end
    end

end