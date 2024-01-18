# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'turbo_redirect' do
    it 'renders a turbo stream' do
      expect(helper.turbo_redirect('https://example.com')).to eq("<turbo-stream action=\"replace\" target=\"turbo-redirect\"><template><div data-controller=\"turbo--redirect-to\" data-url=\"https://example.com\"></div></template></turbo-stream>")
    end
  end
end
