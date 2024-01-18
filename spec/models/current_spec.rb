# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Current do
  describe '.attributes' do
    describe '#current_user' do
      it 'returns the current user' do
        expect(described_class.current_user).to be_nil
      end
    end

    describe '#current_user=' do
      it 'sets the current user' do
        described_class.current_user = 'foo'

        expect(described_class.current_user).to eq('foo')
      end
    end
  end
end
