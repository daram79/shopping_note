class UserRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend_user, :foreign_key => "friend_user_id", :class_name => "User"
end
