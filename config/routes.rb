Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions, only: [:index, :edit, :update, :show, :new, :create] do
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

  get'finish_user_answer' => 'user_answers#finish_user_answer'
  get'sort_user_answer' => 'user_answers#sort_user_answer'
  get'best' => 'user_answers#best'
  patch'update' => 'user_answers#update'

  resources :users_controller, only: [:index]

  resources :articles, only: [:index, :new, :create, :edit, :update]

  resources :products, only: [:index, :edit, :update, :show, :new, :create, :destroy] do
  get 'tags_product' => 'products#tags_product'
    resources :orders, only: [:new, :create]
  end


  resources :orders, only: [:show, :index]  do
    post 'upsell' => 'orders#upsell'
    resources :payments, only: :new
  end

    get 'items_order' => 'orders#items_order'
    post 'items_order_create' => 'orders#items_order_create'

  resources :carts, only: [:show, :destroy]


  resources :items, only: [:create, :destroy]

  post'add_item' => 'items#add_item'
  post'sub_item' => 'items#sub_item'


  get 'quiz' => 'pages#quiz'
  resources :pages, only: :index


  resources :quizzes, only: [:edit, :new, :create] do
    patch 'update' => 'quizzes#update'
    resources :quiz_answers, only: [:edit, :update, :new, :create] do
      patch 'validation' => 'quiz_answers#validation'
    end
  end
    patch 'plus' => 'quizzes#plus'



  resources :tournaments, only: [:index, :show, :new, :create]

  resources :tournaments, only: [:show] do
    patch 'win' => 'tournaments#win'
    patch 'fdd_answer' => 'participations#fdd_answer'
    patch 'granit_answer' => 'participations#granit_answer'
    patch 'katana_answer' => 'participations#katana_answer'
    patch 'draw' => 'participations#draw'
    resources :participations, only: [:create]
  end

  resources :islands, only: [:index, :show, :new, :create] do
    resources :places, only: [:new, :create, :show]
  end

  resources :places, only: [:show] do
    resources :mobs, only: [:new, :create]
  end

  resources :mobs, only: [:show] do
  post 'power' => 'mobs#power'
  post 'run' => 'mobs#run'
  post 'retry_player' => 'mobs#retry_player'
  post 'resolve' => 'mobs#resolve'
  get 'reward' => 'mobs#reward'
  end

  resources :players, only: [:new, :create, :show, :index]


  get 'politique' => 'pages#politique'

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
