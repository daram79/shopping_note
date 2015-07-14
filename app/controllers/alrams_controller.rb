class AlramsController < ApplicationController
  before_action :set_alram, only: [:show, :edit, :update, :destroy]

  def index
    # @alrams = Alram.all
    @my_following_user_ids = current_user.user_relations.pluck(:friend_user_id)
    @alrams = Alram.where(user_id: params[:id]).order("updated_at desc")
    # respond_with(@alrams)
  end

  def show
    respond_with(@alram)
  end

  def new
    @alram = Alram.new
    respond_with(@alram)
  end

  def edit
  end

  def create
    @alram = Alram.new(alram_params)
    @alram.save
    respond_with(@alram)
  end

  def update
    @alram.update(alram_params)
    respond_with(@alram)
  end

  def destroy
    @alram.destroy
    respond_with(@alram)
  end
  
  def get_alram_data
    @alram = Alram.where(user_id: current_user.id, send_flg: true).last
  end
  
  def phone_alram_on
    current_user.alram_on = true
    current_user.save
    render :json => {alram_type: true}
  end
  
  def phone_alram_off
    current_user.alram_on = false
    current_user.save
    render :json => {alram_type: false}
  end

  private
    def set_alram
      @alram = Alram.find(params[:id])
    end

    def alram_params
      params[:alram]
    end
end
