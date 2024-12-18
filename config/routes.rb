Rails.application.routes.draw do
  root "dashboard#index"

  resources :herds, only: [] do
    resources :animals, only: [:create, :update]
  end
end
