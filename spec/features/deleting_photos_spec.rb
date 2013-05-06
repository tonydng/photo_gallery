require 'spec_helper'

feature "Deleting photos" do 
  let!(:user) { Factory(:confirmed_user) }
  let!(:gallery) { Factory(:gallery, user: user) }
  let!(:photo) { Factory(:photo, gallery: gallery, user: user) }

  before do 
    sign_in_as!(user)
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