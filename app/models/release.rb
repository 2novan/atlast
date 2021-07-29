class Release < ApplicationRecord
  belongs_to :artist
  has_many :tracks
  validates :name, :album_type, :release_date, :spotify_id, :image_url, :total_tracks, presence: true

  def duration
    return tracks.sum(&:duration).fdiv(1000) if association(:tracks).loaded?

    @duration ||= self[:duration] || tracks.sum("duration / 1000.0")
  end

  def formatted_duration
    Time.at(duration).utc.strftime("%H:%M:%S")
  end

  def newsfeed_date
    release_date
  end
end
