class ApplicationController < ActionController::Base

  def authenticated?
    session.has_key?(:openid)
  end
  
  def current_user
    User.find_by_open_id_url(session[:openid])
  end
  
end 
