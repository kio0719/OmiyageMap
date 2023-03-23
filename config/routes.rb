Rails.application.routes.draw do
  root :to => 'home#index' 
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get 'users/profile', to: 'users#profile'
  get 'users/profile/edit', to: 'users#profile_edit'
  patch 'users/profile/update', to: 'users#profile_update'
  get 'users/account', to: 'users#account'
  get 'users/account/edit', to: 'users#account_edit'
  patch 'users/account/update', to: 'users#account_update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
