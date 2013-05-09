require 'spec_helper'

feature 'Gmail' do 
	let!(:bob) { Factory(:confirmed_user) }
	let!(:me) { Factory(:confirmed_user, email: "tonydng@gmail.com") }

	before do 
		ActionMailer::Base.delivery_method = :smtp
	end

	after do 
		ActionMailer::Base.delivery_method = :test
	end	

	let!(:gallery) { Factory(:gallery, user: me) }
	let!(:photo) { Factory(:photo, gallery: gallery, user: me) }

	scenario "Receiving a real-world email" do 
		sign_in_as!(bob)
		visit gallery_photo_path(gallery, photo)
		fill_in "New Comment", with: "lovely photo"
		click_button "Create Comment"
		expect(page).to have_content("Comment has been created.")

		expect(photo_gallery_emails.count).to eql(1)
		email = photo_gallery_emails.first
		subject = "[Photo Gallery] #{gallery.name} #{photo.name}"
		expect(email.subject).to eql(subject)
		clear_photo_gallery_emails!
	end
end	