class GalleriesController < ApplicationController
  before_filter :set_gallery, except: [:index, :new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_gallery

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        flash[:success] = 'Gallery has been created.'
        format.html { redirect_to @gallery }
        format.json { render json: @gallery, status: :created, location: @gallery }
      else
        flash.now[:error] = "Gallery has not been created."
        format.html { render action: "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.json
  def update

    respond_to do |format|
      if @gallery.update_attributes(gallery_params)
        flash[:success] = 'Gallery has been updated.'
        format.html { redirect_to @gallery }
        format.json { head :no_content }
      else
        flash.now[:error] = "Gallery has not been updated."
        format.html { render action: "edit" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    flash[:success] = "Gallery has been destroyed." 

    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end

  private

    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params.require(:gallery).permit(:name, :description)
    end

    def invalid_gallery
      logger.error "Attempt to access invalid gallery #{params[:id]}"
      flash[:error] = "The gallery you were looking for could not be found."
      redirect_to galleries_url
    end
end
