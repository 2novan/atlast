class MyArtistsController < ApplicationController
  def destroy
    @artist = Artist.find(params[:id])

    @followed_artist = current_user.followed_artists.find_by!(artist: @artist)

    @followed_artist.destroy

    handle_response_type
  end

  def create
    @artist = Artist.find(params[:artist_id])

    current_user.followed_artists.create(artist: @artist)

    handle_response_type
  end

  private

  def handle_response_type
    respond_to do |format|
      format.html {redirect_to @artist}
      format.json do
        render json: {
          html: render_to_string(
            partial: "shared/follow_artist_btn",
            locals: { artist: @artist },
            formats: [:html]
          )
        }
      end
    end
  end
end
