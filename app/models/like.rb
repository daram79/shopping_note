class Like < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user
  
  after_save :create_feed_data
  after_destroy :delete_feed_data
  
  def create_feed_data
    FeedData.create(user_id: self.user_id, feed_id: self.id, feed_type: "like")
  end
  
  def delete_feed_data
    feed_data = FeedData.where(user_id: self.user_id, feed_id: self.id, feed_type: "like").first
    feed_data.destroy
  end
  
end
