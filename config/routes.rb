Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  post '/missions/:id', to: 'messages#message_send_from_mission_show', as: 'message_send'

  post '/missions/:id/edit', to: 'missions#mission_solved', as: 'mission_solved'


  resources :helpers, only: [:index, :show]
  
  resources :inbox, only: [:index, :update, :destroy]

  resources :after, only: [:show, :update]

  resources :servicesurvey, only: [:show, :update, :create]

  resources :missions, only: [:create, :update, :show, :index, :edit]

  resources :messages, only: [:create, :update, :show, :index]

  resources :useroutsidedevise, only: [:update, :show]

  resources :reviews, only: [:new, :create, :show, :index]

  


end
