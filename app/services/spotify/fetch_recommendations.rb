module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchRecommendations
    def initialize(user)
      @user = user
    end

    def call
      recommendations = RSpotify::Recommendations.generate(limit: 20, seed_artists: artist_seed)

      artists = recommendations.tracks.flat_map(&:artists).uniq(&:id)

      imported_artists = Spotify::FetchArtists.new(artists).call

      Artist.where(id: imported_artists).where.not(id: @user.followed_artists.select(:artist_id)).limit(6)
    end

    private

    def artist_seed
      @user.artists.limit(5).order("RANDOM()").pluck(:spotify_id)
    end
  end
end
