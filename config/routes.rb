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

  direct :cdn_image do |model, options|
    cdn_options = if Rails.env.development?
      Rails.application.routes.default_url_options
    else
      {
        protocol: 'https',
        port: 443,
        host: Rails.application.credentials.dig(:aws, :cdn_host)
      }
    end
  
    if model.respond_to?(:signed_id)
    route_for(
      :rails_service_blob_proxy,
      model.signed_id,
      model.filename,
      options.merge(cdn_options)
    )
    else
    signed_blob_id = model.blob.signed_id
    variation_key  = model.variation.key
    filename       = model.blob.filename
  
    route_for(
      :rails_blob_representation_proxy,
      signed_blob_id,
      variation_key,
      filename,
      options.merge(cdn_options)
    )
    end
  end
end
