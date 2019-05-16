# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users

  resources :rebels, only: [:new, :create]

  namespace :manager do
    resources :rebels
  end

  root to: 'rebels#new'
end
