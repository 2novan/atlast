module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchUserTopArtists
    def initialize(user)
      @user = user
      @spotify_user = RSpotify::User.new('credentials' => { 'token' => @user.token })
    end

    def call
      artists = @spotify_user.top_artists(limit: 50, offset: 0, time_range: 'long_term')

      @imported_artists = Spotify::FetchArtists.new(artists).call

      FollowedArtist.upsert_all(to_follow, unique_by: :index_followed_artists_on_user_id_and_artist_id)
    end

    def to_follow
      timestamp = Time.now

      @imported_artists.map do |artist|
        {
          user_id:    @user.id,
          artist_id:  artist.id,
          created_at: timestamp,
          updated_at: timestamp
        }
      end
    end
  end
end
