class RenameSpotifyIdToUid < ActiveRecord::Migration[6.0]
def change
    rename_column :users, :spotify_id, :uid
  end
end
