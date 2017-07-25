class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with(resource, location: after_sign_in_path_for(resource)) if(after_sign_in_path_for(resource) != "get_districts_by_city")
  end

  def destroy
    super
  end
end
