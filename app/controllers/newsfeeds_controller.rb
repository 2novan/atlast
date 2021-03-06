class NewsfeedsController < ApplicationController
  def show
    @releases = current_user.releases
                            .select("releases.*, SUM(duration / 1000.0) as duration")
                            .joins(:tracks)
                            .includes(:artist)
                            .group("releases.id")
                            .order(release_date: :desc)
  end
end
