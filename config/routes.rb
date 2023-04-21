Rails.application.routes.draw do
  root :to => 'home#index' 
  get '/about', to: 'home#about'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get 'users/:id/profile', to: 'users#profile', as: :users_profile
  get 'users/profile/edit', to: 'users#profile_edit'
  patch 'users/profile/update', to: 'users#profile_update'
  resources :users, only: [] do
    resource :relationships, only: [:create, :destroy]
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

end
