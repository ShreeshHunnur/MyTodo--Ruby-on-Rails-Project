Rails.application.routes.draw do
  root "todos#index"

  resources :todos do
    member do
      patch :update_state
    end
  end
end
