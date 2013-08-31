SimpleStatus::Application.routes.draw do
  devise_for :users

  constraints(MasterDomainConstraint) do
    # platform admin routes here
    namespace "sadmin" do
      resources :plans
      resources :organizations
      root to: 'home#index', as: 'master_root'
    end

    # public website routes here
    resources :organizations
    resources :incoming

    # TODO - DRY this up
    match '/features' => 'home#show', via: :get, page: 'features'
    match '/pricing' => 'home#show', via: :get, page: 'pricing'
    match '/support' => 'home#show', via: :get, page: 'support'
    match '/blog' => 'home#show', via: :get, page: 'blog'
    root to: 'home#index', as: 'master_root'
  end

  constraints(CustomerDomainConstraint) do
    # site admin routes here
    namespace "admin" do
      resources :teams
      resources :status_reports
      resources :status_summaries
      root to: 'home#index', as: 'customer_root'
    end

    # customer routes here
    root to: 'status_reports#index', as: 'customer_root'
    resources :status_reports
  end
end
