class Track < ApplicationRecord
  belongs_to :release

  # def duration
  #   self.duration
  # end

  def formatted_duration
    Time.at(duration).utc.strftime("%S")
  end
end
