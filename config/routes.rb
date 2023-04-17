Rails.application.routes.draw do
  post 'dishes/:id', to: 'dish_ingredients#create'
  get 'chefs/:id/ingredients', to: 'ingredients#index'

  resources :dishes, only: [:show] do
    # resources :dish_ingredients, only: [:create]
  end
  resources :chefs, only: [:show] do
    resources :ingredients, only: [:index]
  end
  resources :ingredients, only: [:index]
end
