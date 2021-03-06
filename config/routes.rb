ActionController::Routing::Routes.draw do |map|
  map.root    :controller => :info, :action => :index
  map.connect "/examples/:action", :controller => :info
  map.connect "/gist/:id.:format", :controller => :gist, :action => :index
end
