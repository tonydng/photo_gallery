require 'spec_helper'

feature 'Signing up' do 
  scenario 'Successful sign up' do 
    visit root_path
    click_link 'Sign up'
    fill_in 'Name', with: 'Example User'
    fill_in 'Email', with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end
end