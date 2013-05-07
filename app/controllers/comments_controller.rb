class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_photo
	before_filter :correct_user

	def create
		@comment = @photo.comments.build(comment_params)
		if @comment.save 
			flash[:success] = "Comment has been created."
			redirect_to [@photo.gallery, @photo]
		else
			flash.now[:error] = "Comment has not been created."
			render template: 'photos/show'
		end
	end

	private
		def set_photo
			@photo = Photo.find(params[:photo_id])
		end

		def comment_params
			params.require(:comment).permit(:content, :user, :photo)
		end

		def correct_user
			if @photo.gallery.user == current_user
				flash[:error] = "You are not authorized to comment for your own photo"
				redirect_to [@photo.gallery, @photo]
			end
		end
end