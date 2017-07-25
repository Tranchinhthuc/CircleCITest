class StaticPagesController < ApplicationController
  def home
    # render layout: false
  end

  def baokim
    render layout: false
  end

  def nganluong
    render layout: false
  end

  def get_districts_by_city
    city = City.find(params[:id])
    districts = city.districts

    render json: districts
  end
end
