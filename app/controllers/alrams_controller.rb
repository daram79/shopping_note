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

  private
    def set_alram
      @alram = Alram.find(params[:id])
    end

    def alram_params
      params[:alram]
    end
end
