class AddLikesCountToVideo < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :likes_count, :integer, default: 0
  end
end
