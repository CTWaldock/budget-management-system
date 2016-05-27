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

  context 'validations' do

    it 'is invalid without a title' do
      new_category = Category.new(budget: @budget)
      expect(new_category).to have(1).error_on(:title)
    end

    it 'is invalid without a budget' do
      new_category = Category.new(title: 'entertainment')
      expect(new_category).to have(1).error_on(:budget)
    end

  end

end
