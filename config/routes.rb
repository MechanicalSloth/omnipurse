Rails.application.routes.draw do
  root 'home#index'
  get ':id', to: 'purse#show'
  get ':id/details', to: 'purse#details'
  get 'search/:address', to: 'purse#search'
end
