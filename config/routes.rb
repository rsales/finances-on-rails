Rails.application.routes.draw do
  # Rotas padrão do Devise
  devise_for :users

  # Rotas para configurações do usuário
  resources :users, only: [] do
    scope "/config" do
      get "general", to: "users/configurations#general", as: :config_general
      get "profile", to: "users/configurations#edit_profile", as: :config_profile
      resources :bank_accounts, only: [ :index, :new, :create ], path: "bank-accounts", controller: "users/bank_accounts"
    end
  end

  # Redireciona a raiz para /finances
  root to: redirect("/finances")

  # Define as rotas para finanças, com family_group_id no padrão de URL
  get "/finances", to: "finances/home#index", as: "finances_home"
  get "/finances/:family_group_id/dashboard", to: "finances/dashboards#show", as: "finances_dashboard"
  get "/finances/:family_group_id/budget", to: "finances/budgets#index", as: "finances_budget"
  get "/finances/:family_group_id/budget/new", to: "finances/budgets#new", as: "new_finances_budget"
  get "/finances/:family_group_id/consolidated", to: "finances/consolidated#index", as: "finances_consolidated"
  get "/finances/:family_group_id/transactions", to: "finances/transactions#index", as: "finances_transactions"
  get "/finances/:family_group_id/transactions/new", to: "finances/transactions#new", as: "new_finances_transaction"

  # Configurações específicas do family_group
  scope "/finances/:family_group_id/config", as: "finances_config" do
    get "general", to: "finances/configurations#general", as: "general"
    get "family-group", to: "finances/configurations#family_group", as: "family_group"
    get "categories", to: "finances/configurations#categories", as: "categories"
    get "types", to: "finances/configurations#types", as: "types"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
