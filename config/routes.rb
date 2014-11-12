Rails.application.routes.draw do
  
  get '/' => 'static_pages#home', as: :home

  # get '/signup' => 'users#new'
  # post '/users' => 'users#create'
  # get '/users/:id' => 'users#show', as: :user_show
  # get '/users/:id/edit' => 'users#edit', as: :user_edit
  # put '/users/:id' => 'users#update', as: :user_update

  resources :users
  get '/users/:id/progress' => 'users#progress', as: :user_progress
  get '/users/:id/test_progress' => 'users#test_progress', as: :user_test_progress
  get 'users/:id/routines' => 'users#routines', as: :user_routines

  resources :notes
  resources :coachings
  resources :routines

  get '/users_levels/:id' => 'users_levels#show', as: :users_level
  put '/users_levels/:id' => 'users_levels#update'

  get '/users_test_levels/:id' => 'users_test_levels#show', as: :users_test_level
  put '/users_test_levels/:id' => 'users_test_levels#update'

  get '/users_skills/:id' => 'users_skills#show', as: :users_skill
  get '/users_field_moves/:id' => 'users_field_moves#show', as: :users_field_move

  get '/signin' => 'sessions#new', as: :signin
  post '/signin' => 'sessions#create', as: :sessions
  delete '/signout' => 'sessions#destroy', as: :signout

end
