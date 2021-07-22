class ReleasesController < ApplicationController

  def show
    @release = Release.find(params[:id])
    artist = @release.artist
    @releases = artist.releases.second_to_last
  end
end
