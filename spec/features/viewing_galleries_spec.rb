require 'spec_helper'

feature 'Viewing Galleries' do 
  scenario "Listing all galleries" do 
    gallery = FactoryGirl.create(:gallery, name: "Last vacation")
    visit root_path
    click_link 'Last vacation'
    expect(page.current_url).to eql(gallery_url(gallery))
  end
end