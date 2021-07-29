module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchArtists
    def initialize(artists)
      @artists = artists
    end

    def call
      @artists.map do |spotify_artist|
        artist = Artist.find_or_create_by(spotify_id: spotify_artist.id)

        if spotify_artist.images.last&.fetch("url")
          artist.update!(
            name: spotify_artist.name,
            image_url: spotify_artist.images.last&.fetch("url"),
            followers: spotify_artist.followers['total'].to_i
          )
        else
          artist.update!(
            name: spotify_artist.name,
            image_url: "http://app.atlast.me/assets/logo-af5ba3dba55686bc42a2a02626b935c39a085202364d32aa5d9df922a78f583b.svg",
            followers: spotify_artist.followers['total'].to_i
          )
        end
        sleep 0.05

        spotify_artist.genres.each do |genre|
          genre = Genre.where({ name: genre }).first_or_create
          artist_genre = ArtistGenre.where({ genre: genre, artist: artist }).first_or_create
        end

        ImportReleasesJob.perform_later(artist)

        artist
      end
    end
  end
end
