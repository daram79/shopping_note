class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_type
  has_many :likes
  has_many :comments
  has_many  :main_feeds, :as => :main
  has_many :feed_photos
  
  after_save :create_main_feed
  after_destroy :destroy_main_feed
  
  accepts_nested_attributes_for :feed_photos, reject_if: :feed_photos_attributes.blank?#, allow_destroy: true
  
  def create_main_feed
    self.main_feeds.create(user_id: self.user_id, sub_type: CONTENT)
  end
  
  def destroy_main_feed
    self.main_feeds.where(sub_type: CONTENT, user_id: self.user_id).destroy_all
  end
end
