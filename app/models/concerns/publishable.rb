# frozen_string_literal: true

module Publishable
  extend ActiveSupport::Concern

  included do
    scope :unpublished, -> { where(published_at: nil) }
    scope :published, -> { where.not(published_at: nil) }

    def published?
      !!published_at
    end

    def publish!
      publish_params = { published_at: Time.current }
      publish_params[:first_published_at] = Time.current if first_published_at.blank?
      update!(publish_params)
    end

    def unpublish!
      update!(published_at: nil)
    end
  end
end
