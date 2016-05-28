require 'rails_helper'

describe 'budget creation' do

  before do
    @user = FactoryGirl.create(:user, time_zone: nil)
  end

  it 'requires users to have a timezone before allowing them to access the budget creation page' do
    login_as(user, :scope => :user)
    visit new_budget_path
    expect(page).to have_content("Set your timezone!")
  end

end
