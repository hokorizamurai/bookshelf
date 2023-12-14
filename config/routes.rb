Rails.application.routes.draw do
  root  "books#index"
  get '/search', to: 'books#search'
end
