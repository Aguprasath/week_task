Rails.application.routes.draw do
  devise_for :users

  root 'topics#index'
  resources :tags
  resources :topics do
    resources :posts do
      member do
        post 'mark_as_read'
      end
      resources :ratings
      resources :comments
    end
  end
  get '/posts', to: 'posts#index'
end

