require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe '#likes_count' do
    fixtures :users
    fixtures :videos

    let(:smith) { users(:smith) }
    let(:james) { users(:james) }
    let(:video) { videos(:published_video) }
    let(:comment) { create(:comment, text: 'hello Smith', user: james, commentable: video) }

    context 'add a like' do
      before do
        expect(comment.likes_count).to eq(0)
      end

      it 'increases the number of likes' do
        comment.likes.create(user: smith)
        expect(comment.likes_count).to eq(1)
      end
    end

    context 'remove a like' do
      before do
        comment.likes.create(user: smith)
        expect(comment.likes_count).to eq(1)
      end

      it 'decreases the number of likes' do
        comment.likes.find_by(user: smith).destroy
        expect(comment.likes_count).to eq(0)
      end
    end
  end
end
