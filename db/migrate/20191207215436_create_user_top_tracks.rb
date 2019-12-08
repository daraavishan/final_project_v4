class CreateUserTopTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_top_tracks do |t|
      t.integer :user_id
      t.string :track_title
      t.string :track_artist
      t.string :track_preview_url

      t.timestamps
    end
  end
end
