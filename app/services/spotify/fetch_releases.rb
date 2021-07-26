module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchReleases
    def initialize(artist)
      @spotify_artist = RSpotify::Artist.find(artist.spotify_id)
      @artist = artist
    end

    def call
      @spotify_artist.albums.each do |spotify_album|
        sleep 0.05

        release_date =
          case spotify_album.release_date_precision
          when "year"  then Date.new(spotify_album.release_date.to_i, 1, 1)
          when "month" then Date.new(*str.split("-").map(&:to_i), 1)
          else spotify_album.release_date
          end

        release = Release.find_or_create_by(spotify_id: spotify_album.id)
        release.update!(
          name: spotify_album.name,
          album_type: spotify_album.album_type,
          artist: @artist,
          image_url: spotify_album.images.last&.fetch("url"),
          total_tracks: spotify_album.total_tracks,
          release_date: release_date
        )

        ImportTracksJob.perform_later(@artist, release)
      end
    end
  end
end
