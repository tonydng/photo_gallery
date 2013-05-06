require 'spec_helper'

feature 'Creating Photos' do 
  let!(:user) {Factory(:confirmed_user) }
  let!(:gallery) { Factory(:gallery, user: user) }
  before do 
    sign_in_as!(user)
    visit root_path
    click_link gallery.name 
    click_link "Add A Photo"
  end

  scenario "Creating a photo" do 
    fill_in "Name", with: "first photo"
    click_button "Create Photo"
    expect(page).to have_content("Photo has been created.")

    click_link "first photo"
    expect(page).to have_content("Created by: #{user.name} (#{user.email})")
  end

  scenario "Creating a photo without a name fails" do 
    click_button "Create Photo"

    expect(page).to have_content("Photo has not been created.")
    expect(page).to have_content("can't be blank")
  end
end