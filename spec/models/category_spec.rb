require 'rails_helper'

describe Category do

  before do
    @budget = FactoryGirl.create(:budget)
    @category = FactoryGirl.create(:category, budget: @budget)
  end

  context 'associations' do

    describe 'budget' do

      it 'belongs to a budget' do
        expect(@category.budget).to eq(@budget)
      end

      it 'subtracts its subtotal from budget when deleted' do
        FactoryGirl.create(:expense, category: @category)
        expect(@budget.total_expense).to eq(10.50)
        @category.destroy
        expect(@budget.total_expense).to eq(0)
      end

    end

    describe 'expenses' do

      it 'has many expenses' do
        expect(@category).to respond_to(:expenses)
      end

      it 'destroys its expenses upon deletion' do
        expense = FactoryGirl.create(:expense, category: @category)
        @category.destroy
        expect(Expense.all).to_not include(expense)
      end

    end

  end

end
