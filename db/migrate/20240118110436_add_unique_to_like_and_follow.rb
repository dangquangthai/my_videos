class AddUniqueToLikeAndFollow < ActiveRecord::Migration[7.1]
  def change
    add_index :follows, [:followable_type, :followable_id, :user_id], unique: true
    add_index :likes, [:likeable_type, :likeable_id, :user_id], unique: true
  end
end
