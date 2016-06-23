class Category < ActiveRecord::Base
  has_many :category_budgets
  has_many :budgets, :through => :category_budgets
  has_many :expenses, :dependent => :delete_all
  before_destroy :subtract_from_budget
  # could potentially use :dependent => destroy instead which would trigger the before destroy expense callbacks to subtract cost from budget, but would be more time intensive

  def current_percentage
    if 1 == 0
      return 0
    else
      ((self.subtotal / 1) * 100).round
    end
  end

  def total_percentage
    ((self.subtotal / 1) * 100).round
  end

  private

  def subtract_from_budget
  # 1 -= self.subtotal
  end

end
