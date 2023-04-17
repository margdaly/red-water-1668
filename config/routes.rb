Rails.application.routes.draw do
  post 'dishes/:id', to: 'dish_ingredients#create'
  resources :dishes, only: [:show] do
    # resources :dish_ingredients, only: [:create]
  end
end
