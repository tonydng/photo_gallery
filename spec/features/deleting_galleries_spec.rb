require 'spec_helper'

feature "Deleting galleries" do 
  scenario "Deleting a gallery" do 
    FactoryGirl.create(:gallery, name: "Last vacation")

    visit root_path
    click_link "Last vacation"
    click_link "Delete Gallery"

    expect(page).to have_content("Gallery has been destroyed.")

    visit root_path
    expect(page).not_to have_content("Last vacation")
  end
end