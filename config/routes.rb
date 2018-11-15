Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :products
    resources :product_lists, only: [:update]
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
        post :pay
        post :unpay
      end
    end
  end

  namespace :account do
    resources :orders
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
    collection do
      delete :clean
      get :checkout
    end
  end

  resources :cart_items do
    member do
      post :change_quantity
    end
  end
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
    resources :certificates
  end

  resources :addresses

  root "products#index"

  get '/addresses/get_address_list', to: 'addresses#get_address_list', as: 'address_list'

  mount ChinaCity::Engine => '/china_city'
end
