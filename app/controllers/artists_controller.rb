class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
    @genre = @artist.genres.collect { |g| (g[:name]).to_s }
    @releases = @artist.releases.first(2)
    @concert = @artist.concerts.first
  end
end
