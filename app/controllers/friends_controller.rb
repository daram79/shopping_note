class FriendsController < ApplicationController
  protect_from_forgery :except => [:add, :following, :unfollowing]
  
  def index
    # today = Time.now.utc.to_date
    search_start_day = Time.now.utc.to_date - 7
    ids = Feed.where("created_at > #{search_start_day}").group(:user_id).pluck(:user_id)
    # ids = User.all.pluck(:id)
    except_user_ids = DeleteRecommendUser.get_excep_user_ids(current_user)
    ids = ids - except_user_ids
    @recommend_users = User.where("id in (?)", ids.sample(10))
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
  
  def get_recommend_users
    ids = User.all.pluck(:id)
    except_user_ids = DeleteRecommendUser.get_excep_user_ids(current_user)
    ids = ids - except_user_ids
    # del_recommend_user_ids = DeleteRecommendUser.where(user_id: current_user.id).pluck(:recommend_user_id)
    # friend_ids = current_user.user_relations.pluck(:friend_user_id)
    # friend_ids.push  current_user.id
    # except_user_ids = del_recommend_user_ids + friend_ids
    # except_user_ids.uniq!
    # ids = ids - except_user_ids
    @recommend_users = User.where("id in (?)", ids.sample(3))
  end
  
  def del_recommend_user
    DeleteRecommendUser.create(user_id: params[:user_id], recommend_user_id: params[:recommend_user_id])
    render json: {status: :ok}
  end
  
end
