# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_user!

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

  private

  def new_video_params
    params.require(:video).permit(:video_url).merge(user: current_user)
  end
end
