# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'rebels#index'

  get '/manager', to: redirect('/rebels')
  get '/manager/rebels', to: redirect('/rebels')

  devise_for :users,
             path: 'auth',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', unlock: 'unlock' }

  resources :calls, only: [:index]
  resources :local_groups
  resources :events
  resources :rebels
  resources :skills
  resources :tags
  resources :users
  resources :working_groups

  namespace :public do
    resources :actions do
      resources :registrations, only: [:new, :create]
    end
    resources :rebels, only: [:new, :create, :edit, :update]
  end
  get '/join', to: 'public/rebels#new'

  namespace :rebels do
    resources :imports, only: [:new, :create]
  end

  namespace :api do
    namespace :private do
      resource :stats, only: :show
    end
  end

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: 'blazer'
  end
end
