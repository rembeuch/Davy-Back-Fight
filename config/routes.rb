Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions, only: [:index, :show, :new, :create] do
    get :sort
    get :sort_tag
    get :sort_finish
    patch :close
    resources :answers , only: [:show, :new, :create] do
      patch :true
      patch :false
      resources :user_answers, only: [:new, :create]
    end
  end

  post 'lock' => 'questions#lock'

  resources :user_answers, only: [:index] do
    patch :win
  end

  get'best' => 'user_answers#best'
  patch'update' => 'user_answers#update'

  resources :users_controller, only: [:index]

  resources :articles, only: [:index, :new, :create]

  resources :products, only: [:index, :edit, :update, :show, :new, :create] do
  get 'tags_product' => 'products#tags_product'
    resources :orders, only: [:new, :create]
  end


  resources :orders, only: [:show, :index]  do
    resources :payments, only: :new
  end

    get 'items_order' => 'orders#items_order'
    post 'items_order_create' => 'orders#items_order_create'

  resources :carts, only: [:show, :destroy]


  resources :items, only: [:create, :destroy]

  post'add_item' => 'items#add_item'
  post'sub_item' => 'items#sub_item'


  resources :pages, only: :index


  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
