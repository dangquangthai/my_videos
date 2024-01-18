class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :video_url, null: false
      t.string :status, null: false, default: 'new'
      t.string :video_id
      t.string :provider
      t.string :thumbnail_url
      t.datetime :published_at
      t.datetime :first_published_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
