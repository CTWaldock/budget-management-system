module BudgetsHelper

  def budget_categories(budget)
    while budget.categories.length < 10 do
      budget.categories.build
    end
    budget.categories
  end

  def show_budget_status(budget)
    if budget.status == "Inactive"
      "Budget Not Yet Active"
    elsif budget.status == "Complete"
      "Budget Completed"
    else
      "Budget in progress with #{budget.remaining_days} days left."
    end
  end

end
