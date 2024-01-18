# frozen_string_literal: true

class Video < ApplicationRecord
  include Videos::YoutubeProvider

  STATUSES = %w[new ready].freeze
  PROVIDERS = %w[youtube].freeze

  belongs_to :user

  validates :video_url, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
end
