class Expense < ActiveRecord::Base
  belongs_to :category
  validates :description, :category, :cost, presence: true
  after_create :add_to_budget_and_category
  after_update :adjust_budget_and_category
  after_destroy :remove_from_budget_and_category

  ##refactor, not DRY, and should expenses be responsible for making adjustments to category and budget?

  def add_to_budget_and_category
    category = self.category
    budget = category.budget
    category.subtotal += self.cost
    category.save
    budget.total_expense += self.cost
    budget.save
  end

  def remove_from_budget_and_category
    category = self.category
    budget = category.budget
    category.subtotal -= self.cost
    category.save
    budget.total_expense -= self.cost
    budget.save
  end

  def adjust_budget_and_category
    category = self.category
    budget = category.budget
    category.subtotal -= self.cost_was
    category.subtotal += self.cost
    category.save
    budget.total_expense -= self.cost_was
    budget.total_expense += self.cost_was
    budget.save
  end

end
