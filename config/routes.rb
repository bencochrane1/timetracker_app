Rails.application.routes.draw do

  get 'accounts/new'

  get 'accounts/create'

  get 'welcome/index'

  root 'welcome#index'
  resources :accounts 

end
