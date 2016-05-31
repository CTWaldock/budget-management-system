require 'rails_helper'

  describe 'budget edit' do

    before do
      @user = FactoryGirl.create(:user)
      @budget = FactoryGirl.create(:budget)
    end

    it 'allows users to add new categories' do
      login_as(@user, :scope => :user)
    end

    it 'allows users to edit category titles' do
    end

    it 'allows users to edit budget details' do
    end

    it 'allows users to delete categories' do
    end
    
  end
