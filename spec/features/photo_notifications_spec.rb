require 'spec_helper'

feature 'Photo Notifications' do 
	let!(:owner) { Factory(:confirmed_user, email: "owner@example.com") }
	let!(:bob)  { Factory(:confirmed_user, email: "bob@example.com") }
	let!(:gallery) { Factory(:gallery, user: owner) }
	let!(:photo) { Factory(:photo, gallery: gallery, user: owner) }

	before do 
		ActionMailer::Base.deliveries.clear
		sign_in_as!(bob)
		visit root_path
	end

	scenario "Photo owner receives notifications about comments" do 
		click_link gallery.name 
		click_link photo.name 
		fill_in "New Comment", with: "it look greate"
		click_button "Create Comment"
		p photo.watchers
		email = find_email!(owner.email)
		subject = "[Photo Gallery] #{gallery.name} - #{photo.name}"
		expect(email.subject).to have_content(subject)
		click_first_link_in_email(email)
		expect(page).to have_content(photo.name)
	end

	scenario "Comment authors are automatically subscribed to a photo" do 
		click_link gallery.name 
		click_link photo.name
		fill_in "New Comment", with: "it looks lovely"
		click_button "Create Comment"
		expect(page).to have_content("Comment has been created.")
		find_email!(owner.email)
		click_link "Sign out"

		reset_mailer

		sign_in_as!(owner)
		click_link gallery.name 
		click_link photo.name 
		lambda { find_email!(owner.email) }.should raise_error
	end

end