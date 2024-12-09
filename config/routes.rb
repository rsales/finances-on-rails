Rails.application.routes.draw do
  root to: redirect("/finances")
  devise_for :users

  # Finances Routes - Home
  get "/finances", to: "finances/home#index", as: "finances_home"

  resources :family_groups, only: [ :index, :new, :create ] do
    post :add_user, on: :member
  end

  # Dashboard
  get "/finances/:family_group_id/dashboard", to: "finances/dashboards#show", as: "finances_dashboard"

  # Budgets Routes
  get "/finances/:family_group_id/budgets", to: "finances/budgets#index", as: "finances_budgets"
  get "/finances/:family_group_id/budget/new", to: "finances/budgets#new", as: "new_finances_budget"
  get "/finances/:family_group_id/budget/edit", to: "finances/budgets#edit", as: "edit_finances_budgets"
  patch "/finances/:family_group_id/budget/update/:month", to: "finances/budgets#update", as: "update_for_month"
  get "/finances/:family_group_id/budget/:month", to: "finances/budgets#show", as: "finances_budget_show"
  post "/finances/:family_group_id/budget", to: "finances/budgets#create", as: "create_finances_budget"

  # Consolidated Routes
  get "/finances/:family_group_id/consolidated", to: "finances/consolidated#index", as: "finances_consolidated"

  # Transactions Routes
  get "/finances/:family_group_id/transactions", to: "finances/transactions#index", as: "finances_transactions"
  get "/finances/:family_group_id/transactions/new/:category_type", to: "finances/transactions#new_by_category_type", as: "new_by_category_type"
  post "/finances/:family_group_id/transactions", to: "finances/transactions#create", as: "create_finances_transaction"
  get "/finances/:family_group_id/transactions/:id/edit", to: "finances/transactions#edit", as: "edit_finances_transaction"
  patch "/finances/:family_group_id/transactions/:id", to: "finances/transactions#update", as: "update_finances_transaction"
  delete "/finances/:family_group_id/transactions/:id", to: "finances/transactions#destroy", as: "destroy_finances_transaction"
  delete "/finances/:family_group_id/transactions/:id/destroy_future", to: "finances/transactions#destroy_future", as: "destroy_future_finances_transaction"
end
