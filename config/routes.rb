Rails.application.routes.draw do
  resources :scans
  resources :checkouts
  resources :products
  root to: 'checkouts#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
