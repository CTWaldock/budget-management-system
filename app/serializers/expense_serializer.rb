class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :cost, :description

  def category_percentage
    object.category_percentage
  end
  
end
