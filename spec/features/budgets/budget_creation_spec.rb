require 'rails_helper'


describe 'budget creation' do

  before do
    @user = FactoryGirl.create(:user)
  end

  it 'requires users to have a timezone before allowing them to access the budget creation page' do
    @user.update(time_zone: nil)
    login_as(@user, :scope => :user)
    visit new_user_budget_path
    expect(page).to have_content("Timezone Settings")
  end

  it 'allows users with timezones to access the budget creation page' do
    login_as(@user, :scope => :user)
    visit new_user_budget_path
    expect(page).to have_content("Budget Specifications")
  end

  it 'does not create a budget with invalid parameters' do
    login_as(@user, :scope => :user)
    visit new_user_budget_path
    click_button ("Create Budget")

    expect(page).to have_content("There was an error creating this budget.")
    expect(page).to have_content("Name cannot be blank")
    expect(page).to have_content("Limit cannot be blank")
    expect(page).to have_content("Start Date cannot be blank")
    expect(page).to have_content("End Date cannot be blank")
  end

  it 'creates a valid budget and redirects to its show page' do
    login_as(@user, :scope => :user)
    visit new_user_budget_path
    fill_in "Name", with: "House Construction Project"
    fill_in "Limit", with: 500000
    fill_in "Start Date", with: Date.current
    fill_in "End Date", with: Date.current + 200
    click_button ("Create Budget")

    expect(page).to have_content("Budget successfully created.")
  end

end
