module Spotify
  RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

  class FetchTracks
    def initialize(artist, release)
      @release = release
      @spotify_album = RSpotify::Album.find(release.spotify_id)
      @artist = artist
    end

    def call
      @spotify_album.tracks.each do |spotify_track|
        sleep 0.05

        track = Track.find_or_create_by(spotify_id: spotify_track.id)
        track.update!(
          name: spotify_track.name,
          duration: spotify_track.duration_ms,
          track_number: spotify_track.track_number,
          release: @release
        )
        TrackArtist.where(track: track, artist: @artist).first_or_create!
      end
    end
  end
end
