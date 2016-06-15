module BudgetsHelper

  def budget_categories(budget)
    while budget.categories.length < 10 do
      budget.categories.build
    end
    budget.categories
  end

  def show_budget_status(budget)
    if budget.status == "Inactive"
      "This budget is not yet active."
    elsif budget.status == "Complete"
      "This budget has been completed."
    else
      "Budget in progress with #{budget.remaining_days} days left."
    end
  end

end
