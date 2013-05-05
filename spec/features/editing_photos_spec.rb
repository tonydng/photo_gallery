require 'spec_helper'

feature "Editing photos" do 
  let!(:user) { Factory(:confirmed_user)}
  let!(:gallery) { Factory(:gallery, user: user) }
  # let!(:photo) {Factory(:photo, gallery: gallery, user: user) }

  before do 
    
    sign_in_as!(user)

    visit root_path
    click_link gallery.name
    click_link photo.name
    click_link "Edit Photo"
  end

  scenario "Updating a photo" do 
    fill_in "Name", with: "updated photo name"
    click_button "Update Photo"

    expect(page).to have_content('Photo has been updated.')
    expect(page).to have_content("updated photo name")
    expect(page).not_to have_content(photo.name)
  end

  scenario "Updating a photo with invalid information fails" do 
    fill_in "Name", with: ""
    click_button "Update Photo"
    expect(page).to have_content('Photo has not been updated.')
  end
end