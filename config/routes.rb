Rails.application.routes.draw do
  resources :topics do
    resources :posts
  end
end

