Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :products do
      member do
        post :start_trading
        post :stop_trading
      end
    end
    resources :product_lists, only: [:update]
    resources :logs, only: [:index]
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
        post :pay
        post :unpay
        post :confirm
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

  resources :verifications do
    collection do
      post :verify
    end
  end

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
    resources :certificates
    resources :invoices
  end

  resources :addresses

  root "products#index"

  get '/addresses/get_address_list', to: 'addresses#get_address_list', as: 'address_list'
  resources :welcome

  mount ChinaCity::Engine => '/china_city'
end
