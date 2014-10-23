class Like < ActiveRecord::Base
  belongs_to  :feed
  belongs_to  :user
  has_many    :main_feeds, :as => :main
  
  after_save :create_main_feed
  after_destroy :delete_main_feed
  
  def create_main_feed
    self.feed.main_feeds.create(user_id: self.user_id, sub_type: LIKE)
  end
  
  def delete_main_feed
    self.feed.main_feeds.where(sub_type: LIKE, user_id: self.user_id).destroy_all
  end
  
end
