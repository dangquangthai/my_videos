require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:likeable) }
  end

  describe 'validations' do
    fixtures :users
    fixtures :videos

    describe 'uniqueness of user_id scoped to likeable_type and likeable_id' do
      subject { create(:like, user: users(:smith), likeable: videos(:published_video)) }

      it { should validate_uniqueness_of(:user_id).scoped_to(%i[likeable_type likeable_id]) }
    end
  end
end
