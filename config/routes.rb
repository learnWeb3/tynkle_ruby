Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  post '/missions/new', to: 'missions#mission_form_creation', as: 'mission_create_outside_survey'

  post '/missions/:id', to: 'messages#message_send_from_mission_show', as: 'message_send'

  post '/missions/:id/edit', to: 'missions#mission_solved', as: 'mission_solved'

  put 'users/edit', to: 'useroutsidedevise#update_skills_and_devices', as: 'update_skills_and_devices'


  resources :helpers, only: [:index, :show]
  
  resources :inbox, only: [:index, :update, :destroy]

  resources :after, only: [:show, :update]

  resources :servicesurvey, only: [:show, :update, :create]

  resources :missions, only: [:create, :update, :show, :index, :edit, :new]

  resources :messages, only: [:create, :update, :show, :index]

  resources :useroutsidedevise, only: [:update, :show]

  resources :reviews, only: [:new, :create, :show, :index]

  resources :images, only: [:show]

  resources :offers, only: [:show, :create, :update, :index]

  
end
