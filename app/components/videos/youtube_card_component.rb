# frozen_string_literal: true

module Videos
  class YoutubeCardComponent < ApplicationComponent
    def initialize(video:, show_controls:)
      @video = video
      @show_controls = show_controls
    end

    attr_reader :video, :show_controls

    def show_controls?
      show_controls && current_user.present? && video.user_id == current_user.id
    end
  end
end
