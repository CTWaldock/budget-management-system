require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'responds to #email' do
    user = FactoryGirl.create(:user, email: 'hey@yahoo.com')
    expect(user.email).to eq('hey@yahoo.com')
  end

  it 'can create users through .from_omniauth' do
    auth = {
      provider: 'fake',
      uid: 100000,
      info: {email: 'fake@yahoo.com'}
    }
    user = User.from_omniauth(auth)
    expect(user).to eq(User.last)
  end

end
