require 'spec_helper'

feature "Editing Galleries" do 

  before do 
    gallery = FactoryGirl.create(:gallery, name: "Last vacation") 
    user = FactoryGirl.create(:user)
    user.confirm!
    gallery.update_attribute(:user, user)

    sign_in_as!(user)

    visit root_path
    click_link "Last vacation"
    click_link 'Edit Gallery'
  end
  scenario "Updating a gallery" do 
    fill_in "Name", with: 'Last vacation udpated'
    click_button 'Update Gallery'

    expect(page).to have_content("Gallery has been updated.")
  end

  scenario "Updating a gallery with invalid attributes is not allowed" do 
    fill_in "Name", with: ""
    click_button "Update Gallery"

    expect(page).to have_content("Gallery has not been updated.")
  end
end