module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class SearchArtists
    def initialize(query)
      @query = query
    end

    def call
      search = RSpotify::Artist.search("%#{@query}%", limit: 3)
      artists = Spotify::FetchArtists.new(search).call
      return artists
    end
  end
end
