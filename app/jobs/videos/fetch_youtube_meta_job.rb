# frozen_string_literal: true

module Videos
  class FetchYoutubeMetaJob < ApplicationJob
    queue_as :default

    def perform(video)
      FetchYoutubeMetaService.new(video: video).perform
    end
  end
end
