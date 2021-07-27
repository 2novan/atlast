require 'sidekiq-scheduler'

class ScrapeArtistConcertsScheduler
  include Sidekiq::Worker

  def perform
    artists = Artist.all
    artists.each do |artist|
      ScrapeArtistConcertsJob.perform_later(artist)
    end
  end
end
