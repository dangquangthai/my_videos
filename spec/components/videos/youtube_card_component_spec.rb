# frozen_string_literal: true

require "rails_helper"

RSpec.describe Videos::YoutubeCardComponent, type: :component do
  describe '#render_inline' do
    fixtures :videos

    let(:video) { videos(:published_video) }
    subject { described_class.new(video: video) }

    it 'renders the component' do
      render_inline(subject)

      expect(page).to have_css('div.font-bold.text-base', text: video.title)
      expect(page).to have_css('div.text-gray-600', text: video.description)
      expect(page).to have_css("iframe[src=\"https://www.youtube-nocookie.com/embed/#{video.video_id}\"]")
    end
  end
end
