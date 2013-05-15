class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_photo
	before_filter :load_commentable
	# before_filter :correct_user

	def index
		@comments = @commentable.comments
	end

	def new
		@comment = @commentable.comments.new
	end

	def create
		@comment = @commentable.comments.new(params[:comment])
		@comment.user = current_user
		if @comment.save 
			flash[:success] = "Comment has been created."
			redirect_to [@commentable.gallery, @commentable]
		else
			flash[:error] = "Comment has not been created because it can not be blank"
			redirect_to [@commentable.gallery, @commentable] #'photos/show'
		end
	end

	private
		def set_photo
			@photo = Photo.find(params[:photo_id])
		end

		# def comment_params
		# 	params.require(:comment).permit(:content, :commentable, :user)
		# end

		def load_commentable
			klass = [Photo].detect {|c| params["#{c.name.underscore}_id"] }
			@commentable = klass.find(params["#{klass.name.underscore}_id"])
		end

		# def correct_user
		# 	if @photo.gallery.user == current_user
		# 		flash[:error] = "You are not authorized to comment for your own photo"
		# 		redirect_to [@photo.gallery, @photo]
		# 	end
		# end
end