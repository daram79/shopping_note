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
    @my_following_user_ids = current_user.user_relations.pluck(:friend_user_id)
  end
  
  def following_list
    user_id = params[:id]
    follower_ids = UserRelation.where(user_id: user_id).pluck(:friend_user_id)
    @followings = User.where(id: follower_ids)
    @my_following_user_ids = current_user.user_relations.pluck(:friend_user_id)
  end
  
  def friend_count
    @user = User.find(params[:id])
  end
  
  def set_registration_id
    @user = User.find(params[:id])
    @user.update(registration_id: params[:registration_id])
    render :json => {status: 200}
  end
    
end