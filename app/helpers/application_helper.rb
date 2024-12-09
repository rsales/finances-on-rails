module ApplicationHelper
  def current_class?(test_path)
    "active" if request.path == test_path
  end

  def new_url(params)
    case params
    when "Receitas"
      "revenue"
    when "Investimentos"
      "investment"
    when "Gastos Fixos"
      "fixed-expenses"
    else
      "variable-expenses"
    end
  end
end
