class PhotosController < ApplicationController
  before_filter :set_gallery
  before_filter :set_photo, except: [:index, :new, :create]

  def new
    @photo = @gallery.photos.build
  end

  def create 
    @photo = @gallery.photos.build(photo_params)
    respond_to do |format|
      if @photo.save
        flash[:success] = 'Photo has been created.'
        format.html { redirect_to @photo.gallery }
        format.json { render json: @photo.gallery, status: :created, location: @gallery }
      else
        flash.now[:error] = "Photo has not been created."
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end

    def set_photo
      @photo = @gallery.photos.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:name)
    end
end
