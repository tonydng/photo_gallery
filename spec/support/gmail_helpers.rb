module GmailHelpers
	def gmail_connection
		settings = ActionMailer::Base.smtp_settings
		@gmail_connection ||= Gmail.connect(settings[:user_name],
																				settings[:password])
	end

	def photo_gallery_emails
		gmail_connection.inbox.find(:unread, from: "Photo Gallery")
	end

	def clear_photo_gallery_emails!
		photo_gallery_emails.map(&:delete!)
	end
end

RSpec.configure do |config|
	config.include GmailHelpers
end