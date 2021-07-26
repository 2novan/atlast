class ScrapeArtistConcertsJob < ApplicationJob
  def perform(artist)
    Songkick::ScrapeArtistConcerts.new(artist).call
  end
end
