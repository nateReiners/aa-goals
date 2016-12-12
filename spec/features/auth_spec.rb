require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => 'testing_username'
      fill_in 'Password', :with => 'biscuits'
      click_on "Sign Up"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end

  end
end

feature "logging in" do
  before(:each) do
    user = User.create!(username: "testing_username", password: "biscuits" )
    visit new_session_url
    fill_in 'Username', :with => 'testing_username'
    fill_in 'Password', :with => 'biscuits'
    click_on "Sign In"
  end

  scenario "shows username on the users profile page after login" do
    expect(page).to have_content "testing_username"
  end

end

feature "logging out" do
  before(:each) do
    visit new_session_path
    user = User.create!(username: "testing_username", password: "biscuits" )

    fill_in 'Username', :with => 'testing_username'
    fill_in 'Password', :with => 'biscuits'
    click_on "Sign In"
    click_on "Sign Out"
    # save_and_open_page
  end

  scenario "begins with a logged out state" do
    expect(current_path).to eq(new_session_path)
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Username'
  end

  scenario "doesn't show Username on the homepage after logout" do
    expect(page).to_not have_content "testing_username"
  end

end
