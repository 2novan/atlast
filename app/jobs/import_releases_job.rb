class ImportReleasesJob < ApplicationJob
  def perform(artist)
    Spotify::FetchReleases.new(artist).call
  end
end
