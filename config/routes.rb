Rails.application.routes.draw do
  resources :scans
  resources :hirings
  resources :checkouts
  resources :employees
  resources :stores
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
