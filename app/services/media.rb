# frozen_string_literal: true

# Handles Media file tasks such as resize
class Media
  TRIM_COMMAND = "ffmpeg \
                    -y \
                    -loglevel error \
                    -hide_banner \
                    -stats \
                    -i %<source_path>s \
                    -vf scale=%<width>s:%<height>s \
                    %<destination_path>s"

  class << self
    def logger
      Rails.logger
    end

    def trim(source_path, destination_path, width: -1, height: -1)
      command = format(TRIM_COMMAND, source_path: source_path, width: width, height: height,
                                     destination_path: destination_path)
      logger.info command
      `#{command}`
    end
  end
end
