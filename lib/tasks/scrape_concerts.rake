desc "Scrape concert for artists"
task scrape_concerts: :environment do
  artists = Artist.all
  artists.each do |artist|
    ScrapeArtistConcertsJob.perform_later(artist)
  end
end
