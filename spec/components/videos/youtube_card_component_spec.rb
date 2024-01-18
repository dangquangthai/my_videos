# frozen_string_literal: true

require "rails_helper"

RSpec.describe Videos::YoutubeCardComponent, type: :component do
  describe '#render_inline' do
    fixtures :users, :videos

    let(:video) { videos(:published_video) }
    let(:expected_show_controls) { false }
    subject { described_class.new(video: video, show_controls: expected_show_controls) }

    context 'when show_controls is true' do
      let(:expected_show_controls) { true }

      it 'renders the component' do
        render_inline(subject)

        expect(page).to have_css('div.font-bold.text-base', text: video.title)
        expect(page).to have_css('div.text-gray-600', text: video.description)
        expect(page).to have_css("div#video-embed-#{video.id}")
        expect(page).to have_css("div#video-#{video.id}")

        expect(page).not_to have_css('[data-controller="turbo--fetch"]', text: 'Unpublish?')
        expect(page).not_to have_css('[data-controller="turbo--fetch"]', text: 'Yes')
      end

      context 'when current_user is present' do
        before do
          Current.current_user = video.user
        end

        context 'when video is published' do
          it 'renders the component' do
            render_inline(subject)

            expect(page).to have_css('[data-controller="turbo--fetch"]', text: 'Unpublish?')
          end
        end

        context 'when video is unpublished' do
          let(:video) { videos(:unpublished_video) }

          it 'renders the component' do
            render_inline(subject)
            expect(page).to have_text('Do you want to publish this video?')
            expect(page).to have_css('[data-controller="turbo--fetch"]', text: 'Yes')
          end
        end

        after do
          Current.current_user = nil
        end
      end
    end

    context 'when show_controls is false' do
      let(:expected_show_controls) { false }

      it 'renders the component' do
        render_inline(subject)

        expect(page).to have_css('div.font-bold.text-base', text: video.title)
        expect(page).to have_css('div.text-gray-600', text: video.description)
        expect(page).to have_css("div#video-embed-#{video.id}")
        expect(page).to have_css("div#video-#{video.id}")

        expect(page).not_to have_css('[data-controller="turbo--fetch"]', text: 'Unpublish?')
        expect(page).not_to have_css('[data-controller="turbo--fetch"]', text: 'Yes')
      end
    end
  end
end
