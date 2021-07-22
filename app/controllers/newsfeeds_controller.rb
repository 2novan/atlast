class NewsfeedsController < ApplicationController
  def show
  end
  def index
    @releases = Release.all
    @releases.each do |release|
      release.tracks.each do |track|
        @duration =+ track.duration
      end
    end
    
  end
end
