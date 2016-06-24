class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :cost, :description, :percentage

  def percentage
    object.category_percentage
  end

  has_one :category
  class CategorySerializer < ActiveModel::Serializer
    attributes :subtotal, :current_percent, :total_percent

    def current_percent
      object.current_percentage
    end

    def total_percent
      object.total_percentage
    end
  end

end
