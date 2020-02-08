Rails.application.routes.draw do

  devise_for :users 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :after, only: [:show, :update]

  resources :servicesurvey, only: [:show, :update]

  resources :missions, only: [:create, :update]


end
