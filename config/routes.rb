Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }

  # resources :meetings do
  #   resources :recordings
  # end

  resources :meetings, :recordings

  root to: 'meetings#index'

  # ACCESSING CALLBACK FROM BBB API WHEN RECORDING IS PROCESSED
  get '/destroy_recording', to: 'recordings#destroy_recording'
  get '/publish',           to: 'recordings#publish'

  # get 'auth/google', as: 'google_login'
  # get '/auth/:provider/callback', to: 'sessions#update'
end
