module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchUserTopArtists
    def initialize(user)
      @user = user
      @spotify_user = RSpotify::User.new('credentials' => { 'token' => User.last.token })
    end

    def call
      artists = @spotify_user.top_artists(limit: 30, offset: 0, time_range: 'medium_term')
      imported_artists = Spotify::FetchArtists.new(artists).call
      imported_artists.each do |artist|
        @user.followed_artists.find_or_create_by(artist: artist)
      end
    end
  end
end
