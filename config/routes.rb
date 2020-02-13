Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'



  resources :inbox, only: [:index, :update, :destroy]

  resources :after, only: [:show, :update]

  resources :servicesurvey, only: [:show, :update, :create]

  resources :missions, only: [:create, :update, :show, :index]

  resources :messages, only: [:create, :update, :show, :index]

  resources :useroutsidedevise, only: [:update]


end
