Rails.application.routes.draw do
  resources :tags
  resources :topics do
    resources :posts do
      resources :comments
    end
  end
  get '/posts', to: 'posts#index'
end

