class RegistrationsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @office = Office.find(params[:office_id])
    @registrations = @office.registrations
  end

  def show
    @office = Office.find(params[:office_id])
    @registration = Registration.find(params[:id])
  end

  def new
    @registration = Registration.new
  end

  def create
    @office = Office.find(params[:office_id])
    @registration = @office.registrations.build(registration_params)
    # @registration.user = current_user.present? ? current_user : User.first
    if @registration.save
      flash[:notice] = "Create successfully!"
      redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    redirect_to :back
  end

  private
  def registration_params
    params.require(:registration).permit(:office_id, :message, :name, :title)
  end
end
