class Concert < ApplicationRecord
  belongs_to :artist
  validates :location, :start_at, :name, presence: true
end
