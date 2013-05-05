require 'spec_helper'

feature "Signing in" do 
	before do 
		@user = FactoryGirl.create(:user, email: "user@example.com")
	end

	scenario 'Signing in via confirmation' do 
		open_email "user@example.com", with_subject: /Confirmation/
		click_first_link_in_email
		message = "Your account was successfully confirmed. You are now signed in."
		expect(page).to have_content(message)
		expect(page).to have_content("Signed in as #{@user.name} (#{@user.email})")
	end
end