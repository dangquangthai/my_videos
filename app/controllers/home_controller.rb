# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @videos = Video.published.newest

    respond_to do |format|
      format.html
    end
  end
end
