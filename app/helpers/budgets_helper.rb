module BudgetsHelper

  def budget_categories(budget)
    while budget.categories.length < 10 do
      budget.categories.build
    end
    budget.categories
  end

  def show_budget_status(budget)
    if budget.start_date > Date.current
      "Budget Not Yet Active"
    elsif budget.end_date <= Date.current
      "Budget Completed"
    else
      "Budget in Progress"
    end
  end

end
