require 'open-uri'

class CreateThumbnailWorker < ApplicationWorker
    extend Memoist
    @queue = :thumbnails_queue
    def perform id
        @id=id
        puts "Running CreateThumbnailWorker worker with #{@id}"
        return unless valid_picture?
        download_source_image
        create_thumbnail
        flink= Filestack::API.new.upload_file(resized_file)
        update_user flink
    end

    private

    memoize def user
        User.find @id
    end

    def download_source_image
        image_url = user.picture
        IO.copy_stream(URI.open(image_url), tempfile)
    end

    memoize def tempfile
        "tmp/#{user.id}-thumbnaiil.jpg"
    end

    memoize def resized_file
        "tmp/#{user.id}-resized.jpg"
    end

    def valid_picture?
        user.picture.present?  
    end

    def update_user flink
        puts "Updating user thumbnail with #{flink.url}"
        user.update! thumbnail: flink.url
    end

    def create_thumbnail
        Media::trim(tempfile, resized_file, height: 200)
    end
end
