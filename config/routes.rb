ActionController::Routing::Routes.draw do |map|
  map.connect 'sc/:controller/:action'
  map.connect 'sc/:controller/:action/:id'
end
