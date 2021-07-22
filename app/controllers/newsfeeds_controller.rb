class NewsfeedsController < ApplicationController
  def show
  end
  def index
    @artists = Artist.all
  end
end
