# frozen_string_literal: true

class Video < ApplicationRecord
  include Videos::YoutubeProvider
  include Publishable

  STATUSES = %w[new failed ready].freeze
  PROVIDERS = %w[youtube].freeze

  belongs_to :user

  validates :video_url, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :provider, inclusion: { in: PROVIDERS }, allow_nil: true

  def ready?
    status == 'ready'
  end

  def new?
    status == 'new'
  end

  def failed?
    status == 'failed'
  end
end
