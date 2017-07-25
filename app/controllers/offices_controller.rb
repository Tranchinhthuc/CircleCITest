class OfficesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @services = Service.all
    @banks = Bank.all
    all_offices = Office.active

    @district_ids = params[:district_ids].present? ? params[:district_ids].map(&:to_i) : []

    @offices = all_offices
    if params[:commit] == "Search"
      if params[:city].present? && !params[:district_ids].present?
        params[:district_ids] = City.find(params[:city]).try(:district_ids)
      end

      if params[:district_ids]
        @offices = all_offices.select{|office| params[:district_ids].map(&:to_i).any?{|district_id| district_id.in?(office.district_ids)}}
      end

      if params[:bank_ids]
        @offices = @offices.select{|office| params[:bank_ids].map(&:to_i).any?{|bank_id| bank_id.in?(office.bank_ids) } }
      end

      if params[:service_ids]
        @offices = @offices.select{|office| params[:service_ids].map(&:to_i).any?{|service_id| service_id.in?(office.service_ids) } }
      end
    end
  end

  def show
    @office = Office.find(params[:id])
    @registrations = @office.registrations

    all_comments = @office.comments.includes(:replies).order(created_at: :desc)
    @root_comments = all_comments.select{|comment| !comment.parent_id.present?}

    @comment = Comment.new
  end

  def new
    if current_user.office.present?
      flash[:notice] = "You have opened an office."
      redirect_to office_path(current_user.office)
      return true
    end
    @district_ids =  params[:district_ids].present? ? params[:district_ids].map(&:to_i) : []
    @office = Office.new
  end

  def create
    if params[:district_ids].present?
      params[:office][:district_ids] = params[:district_ids]
    else
      params[:office][:district_ids] = City.find(params[:office][:city_id]).district_ids
    end
    @office = Office.new(office_params)
    @office.user = current_user
    if @office.save
      flash[:notice] = "Create successfully!"
      redirect_to office_path(@office)
    else
      render "new"
    end
  end

  def edit
    @office = Office.find(params[:id])
    @district_ids = @office.district_ids.present? ? @office.district_ids : (params[:district_ids].present? ? params[:district_ids].map(&:to_i) : [])
  end

  def update
    if params[:district_ids].present?
      params[:office][:district_ids] = params[:district_ids]
    else
      params[:office][:district_ids] = City.find(params[:office][:city_id]).district_ids
    end
    @office = Office.find(params[:id])
    if @office.update_attributes(office_params)
      flash[:notice] = "Create successfully!"
      redirect_to office_path(@office)
    else
      render "edit"
    end
  end

  private
  def office_params
    params.require(:office).permit(:name, :city_id, :cover_picture, :description, :user_id, bank_ids: [], district_ids: [], service_ids: [])
  end
end
