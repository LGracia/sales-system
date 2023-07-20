Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  defaults format: :json do
    get '/sales/search', to: 'sales#search'
  end
end
