require 'spec_helper'

feature "Deleting galleries" do 
	let!(:user) { Factory(:confirmed_user) }
	let!(:gallery) { Factory(:gallery, user: user) }

  scenario "Deleting a gallery" do 
  	sign_in_as!(user)
    visit root_path
    click_link gallery.name
    click_link "Delete Gallery"

    expect(page).to have_content("Gallery has been destroyed.")

    visit root_path
    expect(page).not_to have_content("Last vacation")
  end
end