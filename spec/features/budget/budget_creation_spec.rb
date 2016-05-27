require 'rails_helper'

describe 'budget creation' do

  it 'requires users to have a timezone before allowing them to access the budget creation page' do
    visit new_budget_path
    expect(page).to have_content("Please set a timezone.")
  end

end
