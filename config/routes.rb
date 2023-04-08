Rails.application.routes.draw do
  root :to => 'home#index' 

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get 'users/:id/profile', to: 'users#profile', as: :users_profile
  get 'users/profile/edit', to: 'users#profile_edit'
  patch 'users/profile/update', to: 'users#profile_update'

  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

end
