Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions, only: [:index, :show, :new, :create] do
    resources :answers , only: [:show, :new, :create] do
      resources :user_answers, only: [:new, :create]
    end
  end

  resources :user_answers, only: [:index]
end
