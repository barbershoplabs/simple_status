SimpleStatus::Application.routes.draw do
  devise_for :users

  constraints(MasterDomainConstraint) do
    # platform admin routes here
    namespace "sadmin" do
      resources :plans
      root to: 'home#index', as: 'master_root'
    end

    # public website routes here
    resources :organizations

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
      root to: 'home#index', as: 'customer_root'
    end

    # customer routes here
    root to: 'customer_home#index', as: 'customer_root'
  end
end
