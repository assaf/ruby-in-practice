# This controller provides both username/password authentication
# (using the restful_authentication plugin), and OpenID authentication
# (using the open_id_authentication plugin).


class SessionsController < ApplicationController
  def create
    if using_open_id?
      open_id_authentication
    else
      password_authentication(params[:login], params[:password])
    end
  end

protected

  def password_authentication(name, password)
    if @current_user = User.authenticate(params[:login],
                                         params[:password])
      successful_login
    else
      failed_login "Sorry, that username/password doesn't work"
    end
  end

  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        if @current_user = User.find_by_identity_url(identity_url)
          successful_login
        else
          failed_login "No user with identity #{identity_url}"
        end
      else
        failed_login result.message
      end
    end
  end
  
private

  def successful_login
    session[:user_id] = @current_user.id
    redirect_to root_url
  end

  def failed_login(message = "Login failed.")
    flash[:error] = message
    redirect_to new_session_url
  end
  
end
