require 'rails_helper'

describe 'Budget' do

  before do
    @budget = FactoryGirl.create(:budget)
  end

  it 'has many expenses' do
  end

  'it has many categories through expenses' do
  end

  context 'financial information' do

    it 'has a limit' do
      expect(@budget).to respond_to(:limit)
    end

    it 'has a total expense' do
      expect(@budget).to respond_to(:total_expense)
    end

    it 'has a categorical expense breakdown' do
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



    end

    it 'knows remaining days left' do
    end


    it 'does not allow start date to begin after end date' do
    end

  end

end
