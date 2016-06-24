class CategorySerializer < ActiveModel::Serializer
  attributes :id, :subtotal, :current_percent, :total_percent
  has_many :expenses
  
  def current_percent
    object.current_percentage
  end

  def total_percent
    object.total_percentage
  end

end
