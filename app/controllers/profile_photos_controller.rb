class ProfilePhotosController < ApplicationController
  before_action :set_profile_photo, only: [:show, :edit, :update, :destroy]

  # GET /profile_photos
  # GET /profile_photos.json
  def index
    @profile_photos = ProfilePhoto.all
  end

  # GET /profile_photos/1
  # GET /profile_photos/1.json
  def show
  end

  # GET /profile_photos/new
  def new
    @profile_photo = ProfilePhoto.new
  end

  # GET /profile_photos/1/edit
  def edit
  end

  # POST /profile_photos
  # POST /profile_photos.json
  def create
    @profile_photo = ProfilePhoto.new(profile_photo_params)

    respond_to do |format|
      if @profile_photo.save
        #format.html { redirect_to @profile_photo, notice: 'Profile photo was successfully created.' }
        format.html { redirect_to controller: "settings", action: "index" }
        format.json { render :show, status: :created, location: @profile_photo }
      else
        format.html { render :new }
        format.json { render json: @profile_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_photos/1
  # PATCH/PUT /profile_photos/1.json
  def update
    respond_to do |format|
      if @profile_photo.update(profile_photo_params)
        #format.html { redirect_to @profile_photo, notice: 'Profile photo was successfully updated.' }
        format.html { redirect_to controller: "settings", action: "index" }
        # format.json { render json: @profile_photo, status: :unprocessable_entity }
        format.json { render json: { :success => true, :data => @profile_photo } }
        # format.json { render json: @profile_photo, data: { @profile_photo } 
      else
        format.html { render :edit }
        format.json { render json: @profile_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_photos/1
  # DELETE /profile_photos/1.json
  def destroy
    @profile_photo.destroy
    respond_to do |format|
      format.html { redirect_to profile_photos_url, notice: 'Profile photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_photo
      @profile_photo = ProfilePhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_photo_params
      params[:profile_photo].permit(:user_id, :image)
    end
end
