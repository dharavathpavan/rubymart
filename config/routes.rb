Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  
  root "home#index"
  
  resources :products, only: [:index, :show]
  resource :cart, only: [:show] do
    post "add_item"
    post "remove_item"
    post "update_item"
  end
  
  resources :orders, only: [:index, :show, :create] do
    get 'track', on: :collection
  end
  
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
  
  # Webhooks
  post 'webhooks/stripe', to: 'webhooks#stripe'
end
