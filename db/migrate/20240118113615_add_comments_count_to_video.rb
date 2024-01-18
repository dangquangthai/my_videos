class AddCommentsCountToVideo < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :comments_count, :integer, default: 0
  end
end
