Rails.application.routes.draw do
  devise_for :users

  root 'topics#index'
  resources :tags
  resources :topics do
    resources :posts do
      resources :ratings
      resources :comments
    end
  end
  get '/posts', to: 'posts#index'
end

