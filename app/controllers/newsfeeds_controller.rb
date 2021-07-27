class NewsfeedsController < ApplicationController

  def show
    @releases = current_user.releases.order(release_date: :desc)
  end
  
end
