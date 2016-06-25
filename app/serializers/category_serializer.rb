class CategorySerializer < ActiveModel::Serializer
  attributes :id, :subtotal
  has_many :expenses
  has_one :budget
end
