module PhotosHelper
	def toggle_watching_button
		text = if @photo.watchers.include?(current_user) 
			"Stop watching this photo"
		else
			"Watch this photo"
		end
	
		button_to(text, watch_gallery_photo_path(@photo.gallery, @photo),
			class: 'btn btn-primary')
	end
end
