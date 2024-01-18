class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followable, polymorphic: true

  scope :followers, -> { where(followable_type: 'User') }
end
