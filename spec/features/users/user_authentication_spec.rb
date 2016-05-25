require 'rails_helper'

describe "user registration" do
  it "allows new users to sign up with valid email and password" do
    visit new_user_registration_path

    fill_in "Email", with: "hello@yahoo.com"
    fill_in "Password" with: "whatagreatpassword"
    fill_in "Password confirmation", with: "whatagreatpassword"

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  it "does not allow new users to sign up with invalid information" do
    visit new_user_registration_path

    fill_in "Email", with: "hey@yahoo.com"
    fill_in "Password" with: "whatagreatpassword"
    fill_in "Password confirmation", with: "nottherightpassword"

    click_button "Sign up"

    expect(page).to have_content("Password confirmation doesn't match.")
  end

end

describe "user sign in/sign out" do
  before do
    @user = Factory.create(:user)
  end

  it "allows users to sign in after sign up and sign out" do

    visit new_session_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Sign in"

    expect(page).to have_content("Signed in successfully.")

    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
  end

  it "does not allow user to sign in with wrong password" do
    visit new_session_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: 'wrongpassword'

    click_button "Sign in"

    expect(page).to have_content("Wrong password.")

    expect(page).to_not have_link("Sign out")

  end

end
