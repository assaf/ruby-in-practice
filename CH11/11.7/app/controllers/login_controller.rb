# This controller provides OpenID authentication (using ruby-openid).

require 'openid'

class LoginController < ApplicationController
  def index
    # Show the OpenID login form
  end

  def begin
    openid_url = params[:openid_url]
    openid_res = openid_consumer.begin(openid_url)

    case openid_res.status
      when OpenID::SUCCESS
        # Send the user off to the OpenID server 
        redirect_to openid_res.redirect_url(
                        url_for(:action => :index),
                        url_for(:action => :complete))
      else
        flash[:error] =
          "No OpenID server for <q>#{openid_url}</q>"
        redirect_to :action => 'index'
    end
  end

  def complete
    openid_res = consumer.complete(params)
    case openid_res.status
      when OpenID::SUCCESS
        session[:openid] = openid_res.identity_url
        redirect_to root_url
      else
        flash[:error] =
          "OpenID auth failed: #{openid_res.msg}"
        redirect_to :action => 'index'
    end
  end

protected

   def consumer
     @consumer ||= OpenID::Consumer.new(
                     session[:openid_session] ||= {}, 
                     create_open_id_store)
   end

   def create_open_id_store
     path = "#{RAILS_ROOT}/tmp/openid"
     OpenID::FilesystemStore.new(path)
   end

end
