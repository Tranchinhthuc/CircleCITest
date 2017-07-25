class CommentsController < ApplicationController
  before_action :authenticate_user!

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
    @office = Office.find(params[:office_id])
    @comment = @office.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back}
        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  # def edit
  #   @office = Office.find(params[:id])
  #   @district_ids = @office.district_ids.present? ? @office.district_ids : (params[:district_ids].present? ? params[:district_ids].map(&:to_i) : [])
  # end

  # def update
  #   if params[:district_ids].present?
  #     params[:office][:district_ids] = params[:district_ids]
  #   else
  #     params[:office][:district_ids] = City.find(params[:office][:city_id]).district_ids
  #   end
  #   @office = Office.find(params[:id])
  #   if @office.update_attributes(comment_params)
  #     flash[:notice] = "Create successfully!"
  #     redirect_to office_path(@office)
  #   else
  #     render "edit"
  #   end
  # end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :office_id, :content, :parent_id)
  end
end
