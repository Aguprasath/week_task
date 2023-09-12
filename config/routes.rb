Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

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
  resources :user_comment_ratings, only: [:new, :create]
  get 'view_ratings', to: 'user_comment_ratings#view_ratings'
end

