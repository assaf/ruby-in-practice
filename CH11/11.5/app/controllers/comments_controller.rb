class CommentsController < ApplicationController

  skip_before_filter :login_required, :only => [:index]
  prepend_before_filter :login_or_feed_token_required, :only => [:index]
  session :off, :only => :index, :if => Proc.new { |req| is_feed_request?(req) }

  def index
    @comments = current_user.comments
    respond_to do |format|
      format.html 
      format.rss   { render_rss_feed_for @comments } 
      format.atom  { render_atom_feed_for @comments }
    end
  end

end 
