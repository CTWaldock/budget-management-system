class Expense < ActiveRecord::Base
  belongs_to :category
  validates :description, :category, :cost, presence: true
end
