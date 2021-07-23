class MyArtistsController < ApplicationController
  def destroy
    @artist = Artist.find(params[:id])

    @followed_artist = current_user.followed_artists.find_by(artist: @artist)

    @followed_artist.destroy

    redirect_to @artist
  end

  def create
    @artist = Artist.find(params[:artist_id])

    current_user.followed_artists.create(artist: @artist)

    redirect_to @artist
  end
end
