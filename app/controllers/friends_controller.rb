class FriendsController < ApplicationController
  def index
    friend_ids = current_user.user_relations.pluck(:friend_user_id)
    ids = friend_ids + current_user.id.to_s.split
    @users = User.where("id not in(?)", ids)
  end

  def show
  end

  def edit
  end

  def new
  end
  
  def add
    UserRelation.create(user_id: current_user.id, friend_user_id: params[:id], is_friend: false)
    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { render json: { :success => true } }
    end
  end
  
  def following
    UserRelation.create(user_id: current_user.id, friend_user_id: params[:id], is_friend: false)
    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { render json: { :success => true } }
    end
  end
  
  def unfollowing
    user_relation = UserRelation.where(user_id: current_user.id, friend_user_id: params[:id]).first
    user_relation.destroy
    # UserRelation.create(user_id: current_user.id, friend_user_id: params[:id], is_friend: false)
    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { render json: { :success => true } }
    end
  end
end
