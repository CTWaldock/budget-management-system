class Category < ActiveRecord::Base
  belongs_to :budget
  has_many :expenses

  def current_percentage
    if self.budget.total_expense == 0
      return 0
    else
      ((self.subtotal / self.budget.total_expense) * 100).round
    end
  end

  def total_percentage
    ((self.subtotal / self.budget.limit) * 100).round
  end

end
