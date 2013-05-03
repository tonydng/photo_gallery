require 'spec_helper'

feature 'Creating Photos' do 
  before do 
    FactoryGirl.create(:gallery, name: "Last vacation")
    visit root_path
    click_link "Last vacation"
    click_link "Add a photo"
  end

  scenario "Creating a photo" do 
    fill_in "Name", with: "first photo"
    click_button "Create Photo"

    expect(page).to have_content("Photo has been created.")
  end

  scenario "Creating a photo without a name fails" do 
    click_button "Create Photo"

    expect(page).to have_content("Photo has not been created.")
    expect(page).to have_content("can't be blank")
  end
end