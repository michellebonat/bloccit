Bloccit::Application.routes.draw do
  get "comments/create"
  devise_for :users
   resources :users, only: [:update]
  resources :posts
  # added this for comments exercise
   resources :comments, only: [:create]
   resources :topics

    resources :topics do
      resources :posts, except: [:index]
    end
    
  get 'about' => 'welcome#about'

   root to: 'welcome#index'
end
