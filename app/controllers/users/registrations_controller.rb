class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(user_params)
    # @user.point = 3900
    if @user.save
      flash[:success] = "Sign up completed!"
      sign_in_and_redirect @user
    else
      render 'new'
    end
  end

  def update
    # current_user.update(authentication_token: Devise.friendly_token)
    super
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name)
  end
end
