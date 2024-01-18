require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:followable) }
  end

  describe 'scopes' do
    fixtures :users

    describe '.followers' do
      it 'returns all the followers' do
        james = users(:james)
        smith = users(:smith)

        smith.followers << james
        expect(smith.followers).to eq([james])
        expect(james.followers).to be_empty
      end
    end
  end
end
