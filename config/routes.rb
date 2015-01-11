
class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end


Rails.application.routes.draw do
  get 'users/index'

  constraints(SubdomainPresent) do
    root 'projects#index', as: :subdomain_root
    resources :users, only: :index
    devise_for :users
    
  end
  
  constraints(SubdomainBlank) do
    root 'welcome#index'
    resources :accounts, only: [:new, :create]
  end

end
