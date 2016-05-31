require 'rails_helper'

describe Budget do

  before do
    @budget = FactoryGirl.create(:budget)
  end

  context 'associations' do

    it 'has many categories' do
      expect(@budget).to respond_to(:categories)
    end

    it 'has many individual expenses through categories' do
      expect(@budget).to respond_to(:expenses)
    end

  end

  context 'financial information' do

    it 'has a limit' do
      expect(@budget).to respond_to(:limit)
    end

    it 'has a total expense' do
      expect(@budget).to respond_to(:total_expense)
    end

    it 'knows remaining expense' do
      @budget.update(total_expense: 500.00)
      expect(@budget.remaining_expense).to eq(@budget.limit - @budget.total_expense)
    end

    it 'knows when the limit is exceeded' do
      expect(@budget.exceeded?).to eq(false)
      @budget.update(limit: 100.00, total_expense: 100.01)
      expect(@budget.exceeded?).to eq(true)
    end

    it 'has a daily spending average based on current total expenditure and time passed' do
      @budget.update(total_expense: 200.00)
      expect(@budget.average_expenditure).to eq('Unknown')
      @budget.update(start_date: Date.current - 2)
      expect(@budget.average_expenditure).to eq(100.00)
    end

    it 'has a recommended daily expenditure limit to meet budget' do
      @budget.update(limit: 300.00)
      expect(@budget.recommended_expenditure).to eq(10)
      @budget.update(total_expense: 150.00)
      expect(@budget.recommended_expenditure).to eq(5)
    end

  end

  context 'date related information' do

    context 'status' do

      it 'is active when end date has not been met' do
        expect(@budget.status).to eq('Active')
      end

      it 'is completed when current date is equal or greater than end date' do
        @budget.update(start_date: Date.current - 1, end_date: Date.current)
        expect(@budget.status).to eq('Completed')
      end

      it 'is inactive if current date is not equal to or greater than start date' do
        @budget.update(start_date: Date.current + 1)
        expect(@budget.status).to eq('Inactive')
      end

    end

    it 'knows remaining days left' do
      expect(@budget.remaining_days).to eq(30)
    end

  end

  context 'validations' do

    it 'does not allow start date to begin after end date' do
      new_budget = FactoryGirl.build(:budget, start_date: Date.current, end_date: Date.current - 1)
      expect(new_budget.save).to eq(false)
    end

    it 'requires dates' do
      new_budget = FactoryGirl.build(:budget, start_date: nil, end_date: nil)
      expect(new_budget).to have(1).error_on(:start_date)
      expect(new_budget).to have(1).error_on(:end_date)
    end

    it 'requires a limit' do
      new_budget = FactoryGirl.build(:budget, limit: nil)
      expect(new_budget).to have(2).error_on(:limit)
    end

    it 'requires a name' do
      new_budget = FactoryGirl.build(:budget, name: "")
      expect(new_budget).to have(1).error_on(:name)
    end

  end

  context 'class scopes' do

    it 'knows which budgets are completed' do
      @budget.update(start_date: Date.current - 1, end_date: Date.current)
      expect(Budget.completed).to include(@budget)
    end

    it 'knows which budgets are in progress' do
      expect(Budget.active).to include(@budget)
    end

    it 'knows which budgets have not occurred yet' do
      @budget.update(start_date: Date.current + 1)
      expect(Budget.inactive).to include(@budget)
    end

  end

end
