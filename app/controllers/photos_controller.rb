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

  def edit
  end

  def update
    respond_to do |format|
      if @photo.update_attributes(photo_params)
        flash[:success] = 'Photo has been updated.'
        format.html { redirect_to @photo.gallery }
        format.json { render json: @photo.gallery, status: :created, location: @gallery }
      else
        flash.now[:error] = "Photo has not been updated."
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = "Photo has been deleted."
    respond_to do |format|
      format.html { redirect_to @gallery }
      format.json { head :no_content }
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
      params.require(:photo).permit(:gallery_id, :name, :image, :remote_image_url)
    end
end
