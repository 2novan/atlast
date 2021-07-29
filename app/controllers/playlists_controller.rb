class PlaylistsController < ApplicationController
  
  def new
    user = RSpotify::User.new('id' => current_user.uid, 'credentials' => { 'token' => current_user.token })
    @releases = current_user.releases.order(release_date: :desc)
  end

  def create
    r = DateTime.now
    user = RSpotify::User.new('id' => current_user.uid, 'credentials' => { 'token' => current_user.token })
    @playlist = user.create_playlist!("Atlast-Releases Playlist - #{r.strftime('%d %b %Y')}", public: false)
    tracks = params[:track_ids].map do |spotify_track_id|
      "spotify:track:#{spotify_track_id}"
    end
    @playlist.add_tracks!(tracks)
    redirect_to(playlists_landing_path)
    # if params[:generate_and_open]
    #   # raise
    #   redirect_to(@playlist.external_urls["spotify"])
    # else
    #   # raise
    # end
  end

  def landing

  end

end
