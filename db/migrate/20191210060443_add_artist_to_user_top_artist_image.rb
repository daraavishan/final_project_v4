class AddArtistToUserTopArtistImage < ActiveRecord::Migration[6.0]
  def change
    add_column :user_top_artist_images, :artist, :string
  end
end
