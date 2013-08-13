TeamApk::Application.routes.draw do
  devise_for :users, :skip => [:registrations, :sessions, :passwords]
  root :to                             => 'application#comingsoon'

end
