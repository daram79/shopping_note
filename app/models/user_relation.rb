class UserRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend_user, :foreign_key => "friend_user_id", :class_name => "User"
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    if self.user_id != self.friend_user_id
      self.alram.create(user_id: self.friend_user_id, friend_user_id: self.user_id)
      gcm = GCM.new("AIzaSyDyxck6hFnEtoBkTz3FNdvme3w3csLdTWA")
      registration_ids = [self.alram.last.user.registration_id]
      options = {data: {friend_user_name: self.alram.last.friend_user.nick, alram_type: "UserRelation"}}
      response = gcm.send(registration_ids, options)
    end
  end
  
  def delete_alram
    self.alram.destroy_all
  end
  
end
