class DeleteRecommendUser < ActiveRecord::Base
  belongs_to  :user
  
  def self.get_excep_user_ids(current_user)
    del_recommend_user_ids = DeleteRecommendUser.where(user_id: current_user.id).pluck(:recommend_user_id)
    friend_ids = current_user.user_relations.pluck(:friend_user_id)
    friend_ids.push  current_user.id
    except_user_ids = del_recommend_user_ids + friend_ids
    except_user_ids.uniq!
    return except_user_ids
  end
end
