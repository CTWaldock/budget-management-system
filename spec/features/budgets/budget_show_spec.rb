require 'rails_helper'

describe 'budget show' do

  before do
    @user = FactoryGirl.create(:user)
    @budget = FactoryGirl.create(:budget, user: @user)
    @first_category = @budget.categories.first
    @second_category = FactoryGirl.create(:category, title: "Gas", budget: @budget)
  end

  context 'budget' do

    it 'does not allow users to view budgets that do not belong to them' do
      other_user = FactoryGirl.create(:user, email: "jim@yahoo.com")
      login_as(other_user, :scope => :user)
      visit budget_path(@budget)

      expect(page).to have_content("You don't have access to that budget.")
      expect(page).to_not have_content(@budget.name)
    end

    it 'shows users remaining budget' do
      login_as(@user, :scope => :user)
      visit budget_path(@budget)

      expect(page).to have_content("Expenditure Limit: $10,000.00")
      expect(page).to have_content("Current Expenditure: $0.00")
      expect(page).to have_content("Remaining Expenditure: $10,000.00")

      FactoryGirl.create(:expense, category: @first_category, cost: 1000.00)
      visit budget_path(@budget)

      expect(page).to have_content("Expenditure Limit: $10,000.00")
      expect(page).to have_content("Current Expenditure: $1,000.00")
      expect(page).to have_content("Remaining Expenditure: $9,000.00")

    end

    it 'has a link to edit the budget' do
      login_as(@user, :scope => :user)
      visit budget_path(@budget)

      expect(page).to have_link("Edit Budget Specifications")
    end

    it 'should inform the user regarding its status' do
      login_as(@user, :scope => :user)
      visit budget_path(@budget)
      expect(page).to have_content("Budget in Progress")

      @budget.update(start_date: Date.today + 1)
      visit budget_path(@budget)
      expect(page).to have_content("Budget Not Yet Active")

      @budget.update(start_date: Date.today - 5, end_date: Date.today - 3)
      visit budget_path(@budget)
      expect(page).to have_content("Budget Completed")
    end

  end

  context 'expenses' do

    it 'allows users to add new expenses' do
    end

    it 'shows users top five expenses' do
    end

    it 'shows users five most recent expenses' do
    end

    it 'allows users to delete expenses on the page and adjusts budget accordingly' do
    end

  end

  context 'categories' do

    it 'shows user categorical expenditure breakdown' do
    end

    it 'allows users to click on a link to access category show page' do
    end

    it 'allows users to delete categories and adjusts budget accordingly' do
    end

  end

end
