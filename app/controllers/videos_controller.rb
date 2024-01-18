# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :require_video!, only: %i[publish unpublish embed]

  def index
    @videos = current_user.videos.with_status(filter_status)

    respond_to do |format|
      format.html
    end
  end

  def new
    @new_video = Video.new

    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      format.turbo_stream do
        @new_video = Video.create(new_video_params)
      end
    end
  end

  def publish
    respond_to do |format|
      format.turbo_stream do
        @video.publish!
      end
    end
  end

  def unpublish
    respond_to do |format|
      format.turbo_stream do
        @video.unpublish!
      end
    end
  end

  def embed
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def require_video!
    @video = current_user.videos.find(params[:id])
  end

  def filter_status
    query_params[:status].presence || 'ready'
  end

  def new_video_params
    params.require(:video).permit(:video_url).merge(user: current_user)
  end
end
