class PhotosController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :show]
  before_filter :set_gallery
  before_filter :set_photo, only: [:show, :edit, :update, :destroy, :watch]
  before_filter :correct_user, only: [:create, :edit, :update, :destroy]
  # GET /photos
  # GET /photos.json
  def index
    @photos = @gallery.photos.order("id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @commentable = @photo
    @comments = @commentable.comments
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = @gallery.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @gallery.photos.build(params[:photo])
    @photo.user = current_user
    respond_to do |format|
      if @photo.save
        flash[:success] = "Photo has been created."
        format.html { redirect_to @gallery }
        format.json { render json: @gallery, status: :created, location: @photo }
      else
        flash.now[:error] = "Photo has not been created."
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:success] = "Photo has been updated."
        format.html { redirect_to @gallery }
        format.json { head :no_content }
      else
        flash[:error] = "Photo has not been updated."
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    flash[:success] = "Photo has been deleted."
    respond_to do |format|
      format.html { redirect_to @gallery }
      format.json { head :no_content }
    end
  end

  def watch
    if @photo.watchers.exists?(current_user)
      @photo.watchers -= [current_user]
      flash[:error] = "You are no longer watching this photo."
    else
      @photo.watchers << current_user
      flash[:success] = "You are now watching this photo."
    end

    redirect_to gallery_photo_path(@photo.gallery, @photo)
  end

  private
    def set_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end

    def set_photo
      @photo = @gallery.photos.find(params[:id])
    end
    # # Use this method to whitelist the permissible parameters. Example:
    # # params.require(:person).permit(:name, :age)
    # # Also, you can specialize this method with per-user checking of permissible attributes.
    # def photo_params
    #   params.require(:photo).permit(:galery, :image, :name, :user)
    # end

    def correct_user
      unless @gallery.user == current_user
        flash[:error] = "You are not authorized to do this."
        redirect_to @gallery
      end
    end
end
