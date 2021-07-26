class ImportTracksJob < ApplicationJob
  def perform(artist, release)
    Spotify::FetchTracks.new(artist, release).call
  end
end
