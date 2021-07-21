class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def components
    @artists = Artist.all
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Artist.where("name ILIKE ?", "%#{@parameter}%").first(5)
    end
  end
end
