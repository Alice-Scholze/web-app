Rails.application.routes.draw do
  root 'home#index', as: :home

  get 'test', to: 'home#test'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
