class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_type
  has_many :likes
  has_many :comments
  has_one  :feed_data
  has_many :feed_photos
  
  after_save :create_feed_data
  
  accepts_nested_attributes_for :feed_photos, reject_if: :feed_photos_attributes.blank?#, allow_destroy: true
  
  def create_feed_data
    FeedData.create(user_id: self.user_id, feed_id: self.id, feed_type: "feed")
  end
end
