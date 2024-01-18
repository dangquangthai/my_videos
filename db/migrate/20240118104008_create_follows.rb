class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.string :followable_type
      t.integer :followable_id
      t.timestamps
    end
  end
end
