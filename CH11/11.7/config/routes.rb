ActionController::Routing::Routes.draw do |map|

  # Username/password and OpenID authentication.
  map.resource 'session'  
  map.open_id_complete 'session', :controller => 'sessions',
                                  :action => 'create', 
                                  :requirements => { :method => :get }
end
