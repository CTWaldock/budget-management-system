class Category < ActiveRecord::Base
  belongs_to :budget
  has_many :expenses
  before_destroy :delete_expenses_and_subtract_from_budget
  # could potentially use :dependent => destroy_all instead which would trigger the before destroy expense callback to subtract cost from budget, but would be more time intensive

  def current_percentage
    if budget.total_expense == 0
      return 0
    else
      ((self.subtotal / budget.total_expense) * 100).round
    end
  end

  def total_percentage
    ((self.subtotal / budget.limit) * 100).round
  end

  private

  def delete_expenses_and_subtract_from_budget
    budget.total_expense -= self.subtotal
    budget.save

    self.expenses.delete_all
  end

end
