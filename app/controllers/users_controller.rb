class UsersController < ApplicationController
  before_action :authenticate_user!
  def like_page
    current_user.update_attributes(point: current_user.point+10000)
    render json: current_user
  end

  def unlike_page
    current_user.update_attributes(point: current_user.point-10000)
    render json: current_user
  end

  def share_page
    current_user.update_attributes(point: current_user.point+2000)
    render json: current_user
  end
end
