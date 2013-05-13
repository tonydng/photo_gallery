require 'spec_helper'

feature "Signing in" do 
	before do 
		@user = FactoryGirl.create(:user, email: "user@example.com")
	end

	scenario 'Signing in via confirmation' do 
		open_email "user@example.com", with_subject: /Confirmation/
		# p User.first.confirmation_token
		# p current_email.body
		click_first_link_in_email
		message = "Your account was successfully confirmed. You are now signed in."
		expect(page).to have_content(message)
		expect(page).to have_content("Signed in as #{@user} ")
	end

	scenario "Signing in via form" do 
		User.find_by_email("user@example.com").confirm!
		visit root_path
		click_link 'Sign in'
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		click_button "Sign in"
		expect(page).to have_content("Signed in successfully.")
		expect(page).to have_content("Signed in as #{@user}")
	end
end