# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Videos', type: :request do
  describe 'GET /videos' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get '/videos/new'
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      fixtures :users, :videos

      before do
        sign_in users(:james)
      end

      context 'when q[status] param is not present' do
        it 'returns http success' do
          expect(Videos::YoutubeCardComponent).to receive(:new).exactly(3).times.and_call_original

          get '/videos'
          expect(response).to have_http_status(:success)
        end
      end
        
      context 'when q[status] param is present' do
        it 'returns http success' do
          expect(Videos::YoutubeCardComponent).to receive(:new).exactly(1).times.and_call_original

          get '/videos', params: { q: { status: 'failed' } } 
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'GET /videos/new' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get '/videos/new'
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      fixtures :users

      before do
        sign_in users(:james)
      end

      it 'returns http success' do
        expect(Videos::NewFormComponent).to receive(:new).and_call_original

        get '/videos/new'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        post '/videos'
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      fixtures :users

      before do
        sign_in users(:james)
      end

      it 'creates a video and returns http success' do
        expect(Videos::NewFormComponent).not_to receive(:new)

        expect do
          post '/videos', params: { video: { video_url: 'https://www.youtube.com/watch?v=Vhh_GeBPOhs' } }, as: :turbo_stream
        end.to change { Video.count }.by(1)

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH /publish' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        patch '/videos/1/publish'
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      fixtures :users, :videos

      before do
        sign_in users(:james)
      end

      it 'publishes a video and returns http success' do
        expect do
          patch "/videos/#{videos(:ready_video).id}/publish", as: :turbo_stream
        end.to change { Video.published.count }.by(1)

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH /unpublish' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        patch '/videos/1/unpublish'
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      fixtures :users, :videos

      before do
        sign_in users(:james)
      end

      it 'unpublishes a video and returns http success' do
        expect do
          patch "/videos/#{videos(:published_video).id}/unpublish", as: :turbo_stream
        end.to change { Video.published.count }.by(-1)

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /embed' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get '/videos/1/embed'
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      fixtures :users, :videos

      before do
        sign_in users(:james)
      end

      it 'returns http success' do
        expect(Videos::YoutubeEmbedComponent).to receive(:new).and_call_original

        get "/videos/#{videos(:published_video).id}/embed", as: :turbo_stream
        expect(response).to have_http_status(:success)
      end
    end
  end
end
