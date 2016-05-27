class Category < ActiveRecord::Base
  belongs_to :budget
  has_many :expenses
  validates :title, :budget, presence: true
end
