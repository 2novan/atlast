class Track < ApplicationRecord
  belongs_to :release

  def formatted_duration
    Time.at(duration).utc.strftime("%H:%S")
  end
end
