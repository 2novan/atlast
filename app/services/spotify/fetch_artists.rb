module Spotify
  RSpotify.authenticate("99df90ccb6964e5cbe030a71e89dc1f5", "1b2dc82a4dca4d7f8b0f6026380bcede")

  class FetchArtists
    def initialize(user)
      @user = user
      @spotify_user = RSpotify::User.new('credentials' => { 'token' => User.last.token })
    end

    def call  
      #Fetching Artists

      @spotify_user.top_artists(limit: 10, offset: 0, time_range: 'medium_term').each do |spotify_artist|
        artist = Artist.find_or_create_by(spotify_id: spotify_artist.id)

        artist.update!(
          name:      spotify_artist.name
          image_url: spotify_artist.images.last&.fetch("url")
        )
        sleep 0.05

        @user.followed_artists.find_or_create_by(artist: artist)        

        spotify_artist.genres.each do |genre|
          genre = Genre.where({ name: genre }).first_or_create
          artist_genre = ArtistGenre.where({ genre: genre, artist: artist }).first_or_create
        end

        #Fetching releases

        spotify_artist.albums.each do |spotify_album|
          sleep 0.05

          release_date =
            case spotify_album.release_date_precision
              when "year"  then Date.new(spotify_album.release_date.to_i, 1 , 1)
              when "month" then Date.new(*str.split("-").map(&:to_i), 1)
            else spotify_album.release_date
            end          

          release = Release.find_or_create_by(spotify_id: spotify_album.id)
          release.update!(
            name:         spotify_album.name, 
            album_type:   spotify_album.album_type, 
            artist:       artist, 
            image_url:    spotify_album.images.last&.fetch("url"), 
            total_tracks: spotify_album.total_tracks, 
            release_date: release_date
          )

          spotify_album.tracks.each do |spotify_track|
            sleep 0.05

            track = Track.find_or_create_by(spotify_id: spotify_track.id)
            track.update!(
              name:         spotify_track.name, 
              duration:     spotify_track.duration_ms, 
              track_number: spotify_track.track_number, 
              release:      release
            )

            TrackArtist.where(track: track, artist: artist).first_or_create!
          end
        end
      end
    end
  end
end
