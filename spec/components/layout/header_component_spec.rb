# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Layout::HeaderComponent, type: :component do
  describe '#render_inline' do
    context 'when current_user present' do
      fixtures :users

      before do
        Current.current_user = users(:james)
      end

      it 'renders the header' do
        render_inline(described_class.new)

        expect(page).to have_text('James')
        expect(page).to have_link('New video')
        expect(page).to have_link('My videos')
      end

      after do
        Current.current_user = nil
      end
    end

    context 'when current_user not present' do
      it 'renders the header' do
        render_inline(described_class.new)

        expect(page).to have_link('Sign in')
      end
    end
  end
end
