class NewsfeedsController < ApplicationController

  def show
    @releases = Release.all
  end
end
