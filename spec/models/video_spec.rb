# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:video_url) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(Video::STATUSES) }

    describe '#video_url' do
      subject { build_stubbed(:video) }

      it { should validate_presence_of(:video_url) }
      it { should allow_values('https://youtube.com/watch?v=eZ2Rt2DVGdU').for(:video_url) }
      it { should allow_values('https://youtu.be/eZ2Rt2DVGdU').for(:video_url) }
      it { should_not allow_values('http://example.com', 'https://youtube1.com').for(:video_url).with_message('must be a YouTube URL') }
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
