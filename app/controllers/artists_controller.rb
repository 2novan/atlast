class ArtistsController < ApplicationController
  def index
  end

  def show
    @artist = Artist.find(params[:id])
    @genre = @artist.genres.collect { |g| (g[:name]).to_s }
  end
end
