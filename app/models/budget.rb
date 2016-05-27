class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :categories
  has_many :expenses, :through => :categories
end
