# frozen_string_literal: true

require 'open-uri'

module Videos
  class FetchYoutubeMetaService
    def initialize(video:)
      @video = video
    end

    def perform
      if video_id.blank?
        @failure_message = 'It is not YouTube video url'
      elsif !can_connect_to_youtube?
        @failure_message = "Can't connect to YouTube"
      elsif description.blank? || title.blank?
        @failure_message = 'This video is not available'
      end

      video.update(update_params)
    end

    protected

    attr_reader :video

    def failed_update_params
      {
        status: :failed,
        description: @failure_message,
        title: @failure_message
      }
    end

    def can_connect_to_youtube?
      URI.parse(video.video_url).open.status[0] == '200'
    end

    def update_params
      return failed_update_params if @failure_message.present?

      params = {
        description: description,
        title: title,
        video_id: video_id
      }
      params[:status] = :ready if video.new? || video.failed?

      params
    end

    def description
      @description ||= html_document.at("meta[name='description']")&.[]('content')
    end

    def title
      @title ||= html_document.at_css('title')&.text&.gsub(' - YouTube', '')
    end

    def video_id
      @video_id ||= begin
        macthed = video.video_url.match(YoutubeProvider::YOUTUBE_URL_REGEX)

        return if macthed.blank?

        macthed[1]
      end
    end

    def html_document
      @html_document ||= Nokogiri::HTML(http_response.body)
    end

    def http_response
      @http_response ||= begin
        uri = URI.parse(video.video_url)
        request = Net::HTTP::Get.new(uri.to_s)
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request request }
      end
    end
  end
end
