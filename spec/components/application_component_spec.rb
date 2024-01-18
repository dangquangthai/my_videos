# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationComponent, type: :component do
  describe '.delegations' do
    describe '#current_user' do
      it 'delegates to Current' do
        expect(Current).to receive(:current_user).and_return('foo')

        expect(described_class.new.current_user).to eq('foo')
      end
    end
  end
end
