class CategoryBudget < ActiveRecord::Base
  belongs_to :budget
  belongs_to :category
end
