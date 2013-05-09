class Notifier < ActionMailer::Base
	from_address = ActionMailer::Base.smtp_settings[:user_name]
  default from: "Photo Gallery <#{from_address}>"

  def comment_updated(comment, user)
		@comment = comment 
		@user = user
		@photo = comment.commentable
		@gallery = @photo.gallery
		subject = "[Photo Gallery] #{@gallery.name} - #{@photo.name}"
		mail(to: user.email, subject: subject)
	end
	
end
