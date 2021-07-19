class Artist < ApplicationRecord
  has_many :concerts
  has_many :releases
  has_many :track_artists
  has_many :artist_genres
  has_many :tracks, through: :track_artists
  has_many :genres, through: :artist_genres
  validates :name, :spotify_id, :image_url, presence: true
end
