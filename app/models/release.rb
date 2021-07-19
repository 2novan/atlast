class Release < ApplicationRecord
  belongs_to :artist
  has_many :tracks
  validates :name, :album_type, :release_date, :spotify_id, :image_url, :total_tracks, presence: true
end
