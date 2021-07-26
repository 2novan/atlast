class PlaylistsController < ApplicationController
  
  def new
    @releases = Release.all.order(release_date: :desc)
  end

  def create
    user = RSpotify::User.new('id' => current_user.uid, 'credentials' => { 'token' => current_user.token })
    playlist = user.create_playlist!("Atlast-Releases Playlist", public: false)
    tracks = params[:track_ids].map do |spotify_track_id|
      "spotify:track:#{spotify_track_id}"
    end
    playlist.add_tracks!(tracks)
  end
end
