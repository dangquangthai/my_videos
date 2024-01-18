# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:video_url) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[new failed ready]) }
    it { should validate_inclusion_of(:provider).in_array(%w[youtube]).allow_nil }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe '#after_commit' do
      fixtures :users

      let(:user) { users(:james) }

      context 'when video is from youtube' do
        it 'enqueues a Videos::FetchYoutubeMetaJob' do
          video = build(:video, video_url: 'https://www.youtube.com/watch?v=zxKPjD8urG4', user: user)

          expect(Videos::FetchYoutubeMetaJob).to receive(:perform_later).with(video)

          video.save
        end
      end

      context 'when video is not from youtube' do
        it 'should not enqueue a Videos::FetchYoutubeMetaJob' do
          video = build(:video, video_url: 'https://www.tiktok.com/watch?v=zxKPjD8urG4', user: user)

          expect(Videos::FetchYoutubeMetaJob).not_to receive(:perform_later)

          video.save
        end
      end
    end
  end

  describe '#published?' do
    fixtures :videos

    context 'when status is ready' do
      let(:video) { videos(:new_video) }

      it 'returns true' do
        expect(video.published?).to be false
      end
    end

    context 'when status is not ready' do
      let(:video) { videos(:published_video) }

      it 'returns false' do
        expect(video.published?).to be true
      end
    end
  end

  describe '#from_youtube?' do
    context 'when video_url is from youtube' do
      let(:video) { build_stubbed(:video, video_url: 'https://www.youtube.com/watch?v=zxKPjD8urG4') }

      it 'returns true' do
        expect(video.from_youtube?).to be true
      end
    end

    context 'when video_url is not from youtube' do
      let(:video) { build_stubbed(:video, video_url: 'https://www.tiktok.com/watch?v=zxKPjD8urG4') }

      it 'returns false' do
        expect(video.from_youtube?).to be false
      end
    end
  end

  describe '#publish!', freeze: Time.zone.parse('2024-01-18 17:05:37') do
    fixtures :videos

    context 'first time publish' do
      let(:video) { videos(:new_video) }

      it 'updates published_at and first_published_at' do
        expect do
          video.publish!
        end.to change { video.published_at }.from(nil).to(Time.zone.now)
                                            .and change { video.first_published_at }.from(nil).to(Time.zone.now)
      end
    end

    context 'not first time publish' do
      let(:video) { videos(:unpublished_video) }

      before do
        expect(video.first_published_at).to eq Time.zone.parse('2024-01-18 07:09:00')
      end

      it 'updates only published_at' do
        expect do
          expect do
            video.publish!
          end.to change { video.published_at }.from(nil).to(Time.zone.now)
        end.not_to(change { video.first_published_at })
      end
    end
  end

  describe '#unpublish!' do
    fixtures :videos

    let(:video) { videos(:published_video) }

    it 'updates published_at' do
      expect do
        video.unpublish!
      end.to change { video.published_at }.from(Time.zone.parse('2024-01-18 07:09:00')).to(nil)
    end
  end

  describe '#new?' do
    context 'when status is new' do
      let(:video) { build_stubbed(:video) }

      it 'returns true' do
        expect(video.new?).to be true
      end
    end

    context 'when status is not new' do
      let(:video) { build_stubbed(:video, status: :failed) }

      it 'returns false' do
        expect(video.new?).to be false
      end
    end
  end

  describe '#failed?' do
    context 'when status is not failed' do
      let(:video) { build_stubbed(:video) }

      it 'returns false' do
        expect(video.failed?).to be false
      end
    end

    context 'when status is failed' do
      let(:video) { build_stubbed(:video, status: :failed) }

      it 'returns true' do
        expect(video.failed?).to be true
      end
    end
  end

  describe '#likes_count' do
    fixtures :users
    fixtures :videos

    let(:smith) { users(:smith) }
    let(:james) { users(:james) }
    let(:video) { videos(:published_video) }

    context 'add a like' do
      before do
        expect(video.likes_count).to eq(0)
      end

      it 'increases the number of likes' do
        video.likes.create(user: smith)
        expect(video.likes_count).to eq(1)
      end
    end

    context 'remove a like' do
      before do
        video.likes.create(user: smith)
        video.likes.create(user: james)
        expect(video.likes_count).to eq(2)
      end

      it 'decreases the number of likes' do
        video.likes.find_by(user: smith).destroy
        expect(video.likes_count).to eq(1)
      end
    end
  end
end
