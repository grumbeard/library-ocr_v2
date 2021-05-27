Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'books#index'

  resources :books, only: [:index, :create]
  resources :books, only: [:show] do
    get :reader
  end
end
