# frozen_string_literal: true

require 'open-uri'

# Worker to create thumbnails for user picture
class CreateThumbnailWorker < ApplicationWorker
  extend Memoist
  @queue = :thumbnails_queue
  def perform(id)
    logger.info("Running CreateThumbnailWorker with #{id}")
    @id = id
    return unless valid_picture?

    download_source_image
    create_thumbnail
    flink = Filestack::API.new.upload_file(resized_file)
    update_user flink
  end

  private

  def logger
    Rails.logger
  end

  memoize def user
    User.find @id
  end

  def download_source_image
    image_url = user.picture
    puts "download_source_image #{image_url}"
    IO.copy_stream(URI.open(image_url), tempfile)
  end

  memoize def tempfile
    "tmp/#{user.id}-thumbnail.jpg"
  end

  memoize def resized_file
    "tmp/#{user.id}-resized.jpg"
  end

  def valid_picture?
    user.picture.present?
  end

  def update_user(flink)
    puts "Updating user thumbnail with #{flink.url}"
    user.update! thumbnail: flink.url
    puts "user updated with #{flink.url}"
  end

  def create_thumbnail
    puts 'create_thumbnail'
    Media.trim(tempfile, resized_file, height: 200)
  end
end
