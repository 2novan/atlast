class PlaylistsController < ApplicationController
  
  def new
    @releases = Release.all.order(release_date: :desc)
  end

  def create
    user = RSpotify::User.new('credentials' => { 'token' => User.last.token })
    @playlist = user.create_playlist!("Atlast-Releases Playlist - #{DateTime.now}")
    @playlist = []
    @playlist.add(release.spotify_id)
  end
end
