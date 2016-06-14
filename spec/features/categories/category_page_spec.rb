require 'rails_helper'

describe 'category page' do

  it 'allows users to delete categories and adjusts budget accordingly' do
    login_as(@user, :scope => :user)
    visit category_path(@category)

    click_button "Delete This Category"

    expect(page).to_not have_content("Food")
    expect(page).to have_content("Gas")
    expect(page).to have_content("100%")
    expect(page).to have_content("Current Expenditure: $1,500.00")
    expect(page).to have_content("Remaining Expenditure: $8,500.00")
  end


  it 'allows users to add new expenses and adjusts subtotal and budget accordingly' do
  end

  it 'allows users to delete expenses on the page and adjusts subtotal and budget accordingly' do
  end

end
