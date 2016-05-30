module BudgetsHelper

  def budget_categories(budget)
    while budget.categories.length < 10 do
      budget.categories.build
    end
    budget.categories
  end

end
