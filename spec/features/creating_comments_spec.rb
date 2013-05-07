require 'spec_helper'

feature 'Creating Comments' do 
	let!(:user) { Factory(:confirmed_user) }
	let!(:owner) { Factory(:confirmed_user) }
	let!(:gallery) { Factory(:gallery, user: owner) }
	let!(:photo) { Factory(:photo, gallery: gallery, user: owner) }

	before do 
		sign_in_as!(user)
		visit root_path
		click_link gallery.name
	end

	scenario "Creating a comment" do 
		click_link photo.name 
		fill_in "Content", with: "lovely photo"
		click_button "Create Comment"
		expect(page).to have_content("Comment has been created.")
		expect(page).to have_content("lovely photo")
	end

	scenario "Creating an invalid comment fails" do 
		click_link photo.name
		click_button "Create Comment"
		expect(page).to have_content("Comment has not been created.")
		expect(page).to have_content("can't be blank")
	end

	scenario "Creating an comment for your own photo is not allowed" do 
		click_link "Sign out"
		sign_in_as!(owner)
		visit root_path
		click_link gallery.name
		click_link photo.name
		fill_in "Content", with: "My photo looks the best on this website"
		click_button "Create Comment"
		message ="You are not authorized to comment for your own photo"
		expect(page).to have_content(message)
	end
end