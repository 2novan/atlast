class PlaylistsController < ApplicationController

  def index
    @releases = Release.all
  end

  def new(release)
    user = RSpotify::User.new('credentials' => { 'token' => User.last.token })
    @playlist = user.create_playlist!("Atlast-Releases Playlist - #{DateTime.now}")
    @playlist.add_tracks!(release.tracks)
    
  end
end
