require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'responds to #email' do
    user = FactoryGirl.create(:user, email: 'hey@yahoo.com')
    expect(user.email).to eq('hey@yahoo.com')
  end
end
