require 'spec_helper'

feature "Deleting photos" do 
  let!(:gallery) { FactoryGirl.create(:gallery) }
  let!(:photo) { FactoryGirl.create(:photo, gallery: gallery) }

  before do 
    visit root_path
    click_link gallery.name 
    click_link photo.name
  end

  scenario "Deleting a photo" do 
    click_link "Delete Photo"

    expect(page).to have_content("Photo has been deleted.")
    expect(page.current_url).to eql(gallery_url(gallery))
  end
end