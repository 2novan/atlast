module Spotify
  class FetchUserTopArtistsJob < ApplicationJob
    def perform(user)
      Spotify::FetchUserTopArtists.new(user).call
    end
  end
end
