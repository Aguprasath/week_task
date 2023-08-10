Rails.application.routes.draw do

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

