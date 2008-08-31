class ApplicationController < ActionController::Base

  def login_or_feed_token_required
    if params.has_key?(:token) && (request.format.atom? || request.format.rss?)
      return true if @user = User.find_by_token(params[:token])
    end
    login_required
  end
  
  def self.is_feed_request?(request)
    request.format.atom? || request.format.rss?
  end

end