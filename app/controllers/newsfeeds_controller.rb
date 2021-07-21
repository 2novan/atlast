class NewsfeedsController < ApplicationController
  def index
    @releases = Release.all

  end
end
