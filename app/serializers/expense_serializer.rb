class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :cost, :description, :percentage

  def percentage
    object.category_percentage
  end

end
