class CategoryBudget < ActiveRecord::Migration
  def change
    create_table :category_budgets do |t|
      t.integer :category_id
      t.integer :budget_id
    end
  end
end
