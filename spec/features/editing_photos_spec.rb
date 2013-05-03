require 'spec_helper'

feature "Editing photos" do 
  let!(:gallery) { FactoryGirl.create(:gallery) }
  let!(:photo) { FactoryGirl.create(:photo, gallery: gallery) }

  before do 
    visit root_path
    click_link gallery.name
    click_link "edit"
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