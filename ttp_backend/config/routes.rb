Rails.application.routes.draw do
  resources :users do
    resources :transactions
  end
  
  post '/register', to: 'users#create'
  post '/signin', to: 'users#signin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
