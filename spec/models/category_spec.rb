require 'rails_helper'

describe Category do

  before do
    @budget = FactoryGirl.create(:budget)
    @category = FactoryGirl.create(:category, budget: @budget)
  end

  context 'associations' do

    it 'belongs to a budget' do
      expect(@category.budget).to eq(@budget)
    end

    it 'has many expenses' do
      expect(@category).to respond_to(:expenses)
    end

  end

end
