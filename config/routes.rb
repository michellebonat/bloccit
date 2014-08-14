Bloccit::Application.routes.draw do
  get "comments/create"
  devise_for :users
  resources :users, only: [:update]
  resources :posts

   



   resources :topics

    resources :topics do
      resources :posts, except: [:index] do
        resources :comments, only: [:create]
        post '/up-vote' => 'votes#up_vote', as: :up_vote
        post '/down-vote' => 'votes#down_vote', as: :down_vote
      end  
    end
    
  get 'about' => 'welcome#about'

   root to: 'welcome#index'
end
