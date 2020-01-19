Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions, only: [:index, :show, :new, :create] do
    get :sort
    get :sort_tag
    patch :close
    resources :answers , only: [:show, :new, :create] do
      patch :true
      patch :false
      resources :user_answers, only: [:new, :create]
    end
  end

  resources :user_answers, only: [:index] do
    patch :win
  end

  resources :users_controller, only: [:index]

  resources :articles, only: [:index, :new, :create]

  resources :products, only: [:index, :show, :new, :create] do
    resources :orders, only: [:new, :create]
  end

  resources :orders, only: [:show, :index]  do
    resources :payments, only: :new
  end

  resources :carts, only: [:show, :destroy]

  resources :items, only: [:create, :destroy]

  resources :pages, only: :index


  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
