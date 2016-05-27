class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :categories
  has_many :expenses, :through => :categories
  validates :limit, :start_date, :end_date, presence: true
end
