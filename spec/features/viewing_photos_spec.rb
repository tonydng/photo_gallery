require 'spec_helper'

feature "Viewing photos" do 
  before do 
    gallery_1 = FactoryGirl.create(:gallery, name: "gallery 1")
    FactoryGirl.create(:photo,
            gallery: gallery_1,
            name: "it looks nice")
    gallery_2 = FactoryGirl.create(:gallery, name: "gallery 2")
    FactoryGirl.create(:photo,
            gallery: gallery_2,
            name: "lovely photo")
    visit root_path
  end

  scenario "Viewing photos for a given gallery" do 
    click_link "gallery 1"
    expect(page).to have_content('it looks nice')
    expect(page).not_to have_content('lovely photo')

  end
end