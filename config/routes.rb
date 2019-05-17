# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users,
             path: 'auth',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', unlock: 'unlock' }

  resources :rebels, only: [:new, :create]

  namespace :manager do
    resources :rebels
  end

  root to: 'rebels#new'
end
