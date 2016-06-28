require 'rails_helper'

describe 'category page' do

  before do
    Capybara.current_driver = :selenium
    @user = FactoryGirl.create(:user)
    @budget = FactoryGirl.create(:budget, user: @user, limit: 100)
    @category = @budget.categories.first
    @other_category = FactoryGirl.create(:category, title: "Gas", budget: @budget)
    FactoryGirl.create(:expense, category: @category)
    @expense = FactoryGirl.create(:expense, description: "Burger", cost: 9.50, category: @category)
  end

  it 'restricts access to owner of budget only' do
    other_user = FactoryGirl.create(:user, email: "jim@yahoo.com")
    login_as(other_user, :scope => :user)

    visit category_path(@category)
    expect(page).to have_content("You don't have access to that budget.")
    expect(page).to_not have_content(@category.title)
  end


  it 'lists information regarding the category' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    expect(page).to have_content("Food")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("100%")
    expect(page).to have_content("20%")
  end

  it 'allows the user to return to the budget' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    click_link "Return to Budget"
    expect(page.current_path).to eq budget_path(@budget)
  end

  it 'allows users to delete categories and adjusts budget accordingly' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    click_link "Delete Category"
    expect(page.current_path).to eq budget_path(@budget)
    expect(page).to_not have_content("Food")
    expect(page).to have_content("Current Expenditure: $0.00")
    @budget.reload
    expect(@budget.total_expense).to eq(0)
    expect(@budget.categories.count).to eq(1)
    expect(@budget.expenses).to_not include(@expense)
  end

  it 'shows errors for invalid expenses' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    click_button "Create Expense"

    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Cost can't be blank")
    expect(page).to have_content("Cost is not a number")
  end

  it 'allows users to add new expenses and adjusts subtotal and budget accordingly' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    fill_in "Description", with: "Coke"
    fill_in "Cost", with: "5.00"
    click_button "Create Expense"

    expect(page).to have_content("Coke")
    expect(page).to have_content("25.0")

    @budget.reload
    expect(@budget.total_expense).to eq(25)
    expect(@budget.expenses.last.description).to eq("Coke")
  end

  it 'gives appropriate error messages when fields are not filled in' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    click_button "Create Expense"

    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Cost can't be blank")
    expect(page).to have_content("Cost is not a number")
  end

  it 'allows users to delete expenses on the page and adjusts subtotal and budget accordingly' do
    login_as(@user, :scope => :user)
    visit category_path(@category)
    click_link("Delete Expense", :match => :first)

    expect(page).to_not have_content("Burger")
    expect(page).to_not have_content("$20.00")

    @budget.reload
    expect(@budget.total_expense).to eq(10.50)
  end

end
