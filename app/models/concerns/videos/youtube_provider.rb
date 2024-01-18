# frozen_string_literal: true

module Videos
  module YoutubeProvider
    extend ActiveSupport::Concern

    # https://regex101.com/r/zhaTXK/1
    YOUTUBE_URL_REGEX = %r{(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})}

    included do
      def from_youtube?
        !!(video_url =~ YOUTUBE_URL_REGEX)
      end

      after_commit on: :create do
        Videos::FetchYoutubeMetaJob.perform_later(self) if from_youtube?
      end
    end
  end
end
