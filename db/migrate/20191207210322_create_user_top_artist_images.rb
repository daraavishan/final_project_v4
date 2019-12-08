class CreateUserTopArtistImages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_top_artist_images do |t|
      t.integer :user_id
      t.string :image_url

      t.timestamps
    end
  end
end
