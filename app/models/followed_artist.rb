class FollowedArtist < ApplicationRecord
  belongs_to :artist
  belongs_to :user

  validates :user_id, uniqueness: { scope: :artist_id }
end
