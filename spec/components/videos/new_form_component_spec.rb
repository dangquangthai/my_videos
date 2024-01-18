# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Videos::NewFormComponent, type: :component do
  describe '#render_inline' do
    subject { described_class.new(video: Video.new) }

    it 'renders the form' do
      render_inline(subject)

      expect(page).to have_selector('form')
      expect(page).to have_selector('input[type="text"][name="video[video_url]"]')
      expect(page).to have_selector('input[type="submit"]')
    end
  end
end
