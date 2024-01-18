# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      expect(Layout::HeaderComponent).to receive(:new).and_call_original

      expect(Videos::YoutubeCardComponent).to receive(:new).exactly(1).times.and_call_original

      get '/'
      expect(response).to have_http_status(:success)
    end
  end
end
