class AddIndexToFollowedArtist < ActiveRecord::Migration[6.0]
  def change
    add_index :followed_artists, [:user_id, :artist_id], unique: true
  end
end
