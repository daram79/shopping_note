class Comment < ActiveRecord::Base
  belongs_to  :feed
  belongs_to  :user
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    if self.user_id != self.feed.user_id
      self.alram.create(user_id: self.feed.user_id, friend_user_id: self.user_id)
      # gcm = GCM.new("AIzaSyDyxck6hFnEtoBkTz3FNdvme3w3csLdTWA")
      # registration_ids = [self.alram.last.user.registration_id]
      # options = {data: {friend_user_name: self.alram.last.friend_user.nick, alram_type: "Comment"}}
      # response = gcm.send(registration_ids, options)
    end
  end
  
  def delete_alram
    self.alram.destroy_all
  end
  
  # has_one     :main_feed, :as => :main
#   
  # after_save :create_main_feed
  # after_destroy :delete_main_feed
#   
  # def create_main_feed
    # # self.feed.main_feeds.create(user_id: self.user_id, sub_type: LIKE)
    # self.main_feed.create(user_id: self.user_id)
  # end
#   
  # def delete_main_feed
    # # self.feed.main_feeds.where(sub_type: LIKE, user_id: self.user_id).destroy_all
    # self.main_feed.destroy
  # end
  
end
