require 'spec_helper'

feature "Editing Galleries" do 
  let!(:user) { Factory(:confirmed_user) }
  let!(:gallery) { Factory(:gallery, user: user) }

  before do 
    sign_in_as!(user)

    visit root_path
    click_link gallery.name
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