# frozen_string_literal: true

module Videos
  module YoutubeProvider
    extend ActiveSupport::Concern

    # https://regex101.com/r/zhaTXK/1
    YOUTUBE_URL_REGEX = %r{(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})}

    included do
      validates :video_url, format: {
        with: YOUTUBE_URL_REGEX,
        message: 'must be a YouTube URL'
      }
    end
  end
end
