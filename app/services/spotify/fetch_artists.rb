module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchArtists
    def initialize(artists, force_update: false)
      @artists      = artists
      @force_update = force_update
    end

    def call
      @artist_spotify_ids = @artists.map(&:id)

      artists_to_import_or_update.map(&method(:fetch))

      Artist.where(spotify_id: @artist_spotify_ids)
    end

    private

    def fetch(spotify_artist)
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

    def artists_to_import_or_update
      ids = @force_update ? @artist_spotify_ids : (@artist_spotify_ids - imported_artist_ids)

      @artists.select { |artist| ids.include?(artist.id) }
    end

    def imported_artist_ids
      @imported_artist_ids ||= Artist.where(spotify_id: @artist_spotify_ids).pluck(:spotify_id)
    end
  end
end
