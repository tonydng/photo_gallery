require 'spec_helper'

feature "Watching photos" do 
	let!(:user) { Factory(:confirmed_user) }
	let!(:gallery) { Factory(:gallery, user: user) }
	let!(:photo) { Factory(:photo, gallery: gallery, user: user) }

	before do 
		sign_in_as!(user)
		visit root_path
	end

	scenario "Photo watch toggling" do 
		click_link gallery.name 
		click_link photo.name
		expect(page).to have_content(user.name)

		click_button "Stop watching this photo"
		expect(page).to have_content("You are no longer watching this photo.")
		within('#watchers') do
			expect(page).not_to have_content(user)
		end

		click_button "Watch this photo"
		expect(page).to have_content("You are now watching this photo.")
		within("#watchers") do
			expect(page).to have_content(user)
		end
	end
end