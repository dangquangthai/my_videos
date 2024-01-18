# frozen_string_literal: true

require "rails_helper"

RSpec.describe Videos::YoutubeEmbedComponent, type: :component do
  describe '#render_inline' do
    fixtures :videos
    it 'renders the component' do
      video = videos(:published_video)
      render_inline(described_class.new(video: video))

      expect(page).to have_css("iframe[src='https://www.youtube-nocookie.com/embed/#{video.video_id}']")
    end
  end
end
