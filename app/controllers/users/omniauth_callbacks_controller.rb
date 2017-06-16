class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    # if current_user
    #   if current_user.ordinary_user?
    #     if User.find_by(provider: auth.provider, uid: auth.uid).nil?
    #       current_user.update_attributes(provider: auth.provider,
    #         uid: auth.uid, facebook_token: auth.credentials.token)
    #     else
    #       flash[:danger] = "This Facebook account is already connected to another user."
    #     end
    #   else
    #     flash[:danger] = "Cannot link to facebook account!"
    #   end
    #   redirect_to edit_user_registration_path
    # else
      user = User.find_user_by_facebook_info(auth)
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      if user.nil?
        user = User.create_new_user_with_facebook_account(request.env["omniauth.auth"])
        # UserMailer.send_password(user).deliver_now
        # Profile.create(user_id: user.id)
        sign_in user
        # AuditLog.create(audit_log_type: 'login_with_facebook', datetime: Time.now,
        #   remote_ip: request.remote_ip, ip: request.ip, authenticated: true,
        #   email: user.email, password: "********")
        # redirect_to edit_user_registration_path
        redirect_to root_path
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        # if user.ordinary_user?
          # AuditLog.create(audit_log_type: 'login_with_facebook', datetime: Time.now,
          #   remote_ip: request.remote_ip, ip: request.ip, authenticated: true,
          #   email: user.email, password: "********")
          sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        # else
        #   flash[:danger] = "Cannot link to facebook account! Please login with email!"
        #   redirect_to root_path
        # end
      end
    # end
  end

  def failure
    redirect_to root_path
  end
end
