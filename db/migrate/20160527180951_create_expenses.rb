class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :category_id
      t.float :cost

      t.timestamps null: false
    end
  end
end
