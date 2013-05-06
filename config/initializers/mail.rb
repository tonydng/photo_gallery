ActionMailer::Base.smtp_settings = {
	user_name: ENV['GMAIL_SMTP_USER'],
	password: ENV['GMAIL_SMTP_PASSWORD'],
	address: "smtp.gmail.com",
	port: 587,
	enable_tarttls_auto: true
}