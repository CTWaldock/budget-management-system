class BudgetSerializer < ActiveModel::Serializer
  attributes :id, :limit, :total_expense
end
