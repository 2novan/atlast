class Concert < ApplicationRecord
  belongs_to :artist
  validates :location, :start_at, :name, presence: true

  def newsfeed_date
    start_at
  end
end
