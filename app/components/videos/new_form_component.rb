# frozen_string_literal: true

module Videos
  class NewFormComponent < ApplicationComponent
    def initialize(video:)
      @video = video
    end

    attr_reader :video
  end
end
