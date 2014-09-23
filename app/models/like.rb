class Like < ActiveRecord::Base
  belongs_to :feed
  
  after_save :create_feed_data
  
  def create_feed_data
    FeedData.create(user_id: self.user_id, feed_id: self.id, feed_type: "like")
  end
  
end
