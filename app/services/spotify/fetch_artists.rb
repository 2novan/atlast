module Spotify
  RSpotify.authenticate("99df90ccb6964e5cbe030a71e89dc1f5", "1b2dc82a4dca4d7f8b0f6026380bcede")

  class FetchArtists

    def initialize(user)
      @user = user
      @spotify_user = RSpotify::User.new('credentials' => { 'token' => User.last.token })
    end

    def call  # Spotify::FetchArtists.new(User.last).call
      # rails c -> reload!
      @spotify_user.top_artists(limit: 5, offset: 0, time_range: 'medium_term').each do |spotify_artist|
        artist = Artist.where({name: spotify_artist.name, spotify_id: spotify_artist.id, image_url: spotify_artist.images.last["url"] }).first_or_create
        FollowedArtist.where({artist: artist, user: @user}).first_or_create
        spotify_artist.genres.each do |genre|
          genre = Genre.where({name: genre}).first_or_create
          artist_genre = ArtistGenre.where({genre: genre, artist: artist}).first_or_create
        end
        spotify_artist.albums.each do |release|
          album = Release.where({name: release.name, album_type: release.album_type, spotify_id: release.id, image_url: release.images.last["url"], total_tracks: release.total_tracks}).first_or_create
          album.tracks.each do |track|
            track = Track.where({name: track.name, duration: track.duration_ms, track_number: track.track_number, spotify_id: track.id})
          end
        end
      end
      # albums = artist.albums.each do |album|
      #   release = Release.where({name: album.name, album_type: album.album_type, release_date: album.release_date, spotify_id: album.id, image_url:  })
      # end

        # Recuperer les genres et les envoyer dans la table genre puis les associer avec genre_id
      
          # genres each 
          #   genre = Genre first_or_create
          #   GenreArtist..where(genre: genre, artist: artist).first_or_create
    end
  end
end