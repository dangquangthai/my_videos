# frozen_string_literal: true

module ApplicationHelper
  include Turbo::StreamsHelper

  def turbo_redirect(url)
    turbo_stream.replace('turbo-redirect') do
      content_tag :div, nil, data: { controller: 'turbo--redirect-to', url: url }
    end
  end
end
