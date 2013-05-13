require 'spec_helper'

feature "Creating Users" do 
	let!(:admin) { Factory(:admin_user) }
	before do 
		sign_in_as!(admin)
		visit root_path
		click_link "Admin"
		click_link "Users"
		click_link "New User"
	end

	scenario "Creating a new user" do 
		fill_in "Name", with: "New User"
		fill_in "Email", with: "newuser@example.com"
		fill_in "Password", with: "password"
		click_button "Create User"
		expect(page).to have_content("User has been created.")
	end

	scenario "Creating a new user without a name is invalid" do 
		fill_in "Name", with: ""
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		click_button "Create User"
		expect(page).to have_content("User has not been created.")
	end

	scenario "Creating a new user with an invalid email fails" do 
		fill_in "Name", with: "New User"
		fill_in "Email", with: ""
		fill_in "Password", with: "password"
		click_button "Create User"
		expect(page).to have_content("User has not been created.")
	end

	scenario "Creating an admin user" do 
		fill_in "Name", with: "Admin User"
		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"
		check "Admin"
		click_button "Create User"
		expect(page).to have_content("User has been created.")
		expect(page).to have_content("Admin User <admin@example.com> (Admin)")
	end

end