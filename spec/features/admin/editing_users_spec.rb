require 'spec_helper'

feature 'Editing a user' do 
	let!(:admin) { Factory(:admin_user) }
	let!(:user) { Factory(:confirmed_user) }

	before do 
		sign_in_as!(admin)
		visit root_path
		click_link "Admin"
		click_link "Users"
		click_link user
		click_link "Edit User"
	end

	scenario "Updating a user's details" do
		fill_in "Name", with: "New Guy" 
		fill_in "Email", with: "newguy@example.com"
		click_button "Update User"
		expect(page).to have_content("User has been updated.")
		expect(page).to have_content("New Guy <newguy@example.com> (User)")
		expect(page).not_to have_content(user.name)
	end

	scenario "Toggling user's admin ability" do 
		check "Admin"
		click_button "Update User"
		expect(page).to have_content("User has been updated.")
		expect(page).to have_content("#{user.name} <#{user.email}> (Admin)")
	end

	scenario "Updating with an empty name fails" do 
		fill_in "Name", with: ""
		click_button "Update User"
		expect(page).to have_content("User has not been updated.")
		expect(page).to have_content("can't be blank")
	end

	scenario "Updating with an invalid email fails" do 
		fill_in "Email", with: "fakefake"
		click_button "Update User"
		expect(page).to have_content("User has not been updated.")
		expect(page).to have_content("is invalid")
	end
end