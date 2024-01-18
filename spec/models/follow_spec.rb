require 'rails_helper'

RSpec.describe Follow, type: :model do
  fixtures :users

  let(:james) { users(:james) }
  let(:smith) { users(:smith) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:followable) }
  end

  describe 'validations' do
    describe 'uniqueness of user_id scoped to followable_type and followable_id' do
      subject { create(:follow, user: smith, followable: james) }

      it { should validate_uniqueness_of(:user_id).scoped_to(%i[followable_type followable_id]) }
    end
  end

  describe 'scopes' do
    describe '.followers' do
      it 'returns all the followers' do
        smith.followers << james
        expect(smith.followers).to eq([james])
        expect(james.followers).to be_empty
      end
    end
  end
end
