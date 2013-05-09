class Notifier < ActionMailer::Base
  default from: "tonydng@gmail.com"

  def comment_updated(comment, user)
		@comment = comment 
		@user = user
		@photo = comment.commentable
		@gallery = @photo.gallery
		subject = "[Photo Gallery] #{@gallery.name} - #{@photo.name}"
		mail(to: user.email, subject: subject)
	end
	
end
