Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, :sessions, :events, :joins
  post '/comments/:id' => 'comments#create'
end
