# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Videos::FetchYoutubeMetaJob, type: :job do
  fixtures :videos

  let(:video) { videos(:new_video) }

  describe '#perform_later' do
    it 'enqueues a job' do
      expect do
        described_class.perform_later(video)
      end.to have_enqueued_job
    end
  end

  describe '#perform_now' do
    let(:mocked_service) { double(perform: true) }

    it 'executes Videos::FetchYoutubeMetaService' do
      expect(Videos::FetchYoutubeMetaService).to receive(:new)
        .with(video: video)
        .and_return(mocked_service)

      described_class.perform_now(video)
    end
  end
end
