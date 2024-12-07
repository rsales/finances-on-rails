Rails.application.routes.draw do
  root to: redirect("/finances")
  devise_for :users

  get "/finances", to: "finances/home#index", as: "finances_home"

  get "/finances/:family_group_id/dashboard", to: "finances/dashboards#show", as: "finances_dashboard"

  get "/finances/:family_group_id/budgets", to: "finances/budgets#index", as: "finances_budgets"
  get "/finances/:family_group_id/budget/new", to: "finances/budgets#new", as: "new_finances_budget"
  get "/finances/:family_group_id/budget/edit", to: "finances/budgets#edit", as: "edit_finances_budgets"
  patch "/finances/:family_group_id/budget/update/:month", to: "finances/budgets#update", as: "update_for_month"
  get "/finances/:family_group_id/budget/:month", to: "finances/budgets#show", as: "finances_budget_show"
  post "/finances/:family_group_id/budget", to: "finances/budgets#create", as: "create_finances_budget"

  get "/finances/:family_group_id/consolidated", to: "finances/consolidated#index", as: "finances_consolidated"

  get "/finances/:family_group_id/transactions", to: "finances/transactions#index", as: "finances_transactions"
  get "/finances/:family_group_id/transactions/:transaction_id/edit", to: "finances/transactions#edit", as: "edit_finances_transaction"
  get "/finances/:family_group_id/transactions/new/:category_type", to: "finances/transactions#new_by_category_type", as: "new_by_category_type"
  post "/finances/:family_group_id/transactions", to: "finances/budgets#create", as: "create_finances_transaction"

  # namespace :finances do
  #   resources :family_groups, only: [] do
  #     resources :transactions, only: [ :index, :new, :create, :edit, :update, :destroy ] do
  #       collection do
  #         get "new/:category_type", to: "transactions#new_by_category_type", as: "new_by_category_type"
  #       end
  #     end
  #   end
  # end

  # resources :users, only: [] do
  #   scope "/config" do
  #     get "profile", to: "users/configurations#edit_profile", as: :config_profile
  #     resources :bank_accounts, only: [ :index, :new, :create ], path: "bank-accounts", controller: "users/bank_accounts"
  #   end
  # end

  # scope "/finances/:family_group_id/config", as: "finances_config" do
  #   get "family-group", to: "finances/configurations#family_group", as: "family_group"
  #   get "categories", to: "finances/configurations#categories", as: "categories"
  #   get "types", to: "finances/configurations#types", as: "types"
  # end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
