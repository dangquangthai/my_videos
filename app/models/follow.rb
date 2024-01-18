# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followable, polymorphic: true

  scope :followers, -> { where(followable_type: 'User') }

  validates :user_id, uniqueness: {
    scope: %i[followable_type followable_id]
  }
end
