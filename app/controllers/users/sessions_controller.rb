class Users::SessionsController < Devise::SessionsController
  def new
    super
  end
 
  def create
    super
  end
 
  def destroy
    super
  end
  def info
    @user = User.find(params[:id])
  end
  
  def follower_list
    user_id = params[:id]
    follower_ids = UserRelation.where(friend_user_id: user_id).pluck(:user_id)
    @followers = User.where(id: follower_ids)
  end
  
  def following_list
    user_id = params[:id]
    follower_ids = UserRelation.where(user_id: user_id).pluck(:friend_user_id)
    @followings = User.where(id: follower_ids)
  end
end