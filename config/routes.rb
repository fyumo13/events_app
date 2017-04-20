Rails.application.routes.draw do
  resources :users, :sessions, :events, :joins
  post '/comments/:id' => 'comments#create'
end
