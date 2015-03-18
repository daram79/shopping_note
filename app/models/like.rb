# encoding: utf-8
require 'gcm'

class Like < ActiveRecord::Base
  belongs_to  :feed
  belongs_to  :user
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    if self.user_id != self.feed.user_id
      self.alram.create(user_id: self.feed.user_id, friend_user_id: self.user_id)
      gcm = GCM.new("AIzaSyDyxck6hFnEtoBkTz3FNdvme3w3csLdTWA")
      registration_ids = [self.alram.last.user.registration_id]
      options = {data: {friend_user_name: self.alram.last.friend_user.nick, alram_type: "Like"}}
      response = gcm.send(registration_ids, options)
      # gcm = GCM.new("AIzaSyDyxck6hFnEtoBkTz3FNdvme3w3csLdTWA")
      # registration_ids = ["APA91bF83vi9n2QeqqjqOBGAOsCdS157E0Y3A75yZggvBrZ2bh5X3PINuyDyFDh8MxqZj87XDxrmB1JRZrp18ELSfLutccbdJE9_M27Y1eAd7y0WrXxeoA6VW4jKThRlW9iLJ0tUfiDrIAwSYg7-pyEDmMb_HbWK_Q"]
      # options = {data: {score: "123"}, collapse_key: "updated_score"}
      # response = gcm.send(registration_ids, options)
    end
  end
  
  def delete_alram
    self.alram.destroy_all
  end
  # has_one    :main_feed, :as => :main
  
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
