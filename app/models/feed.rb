class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_type
  has_many :likes
  has_many :comments
  has_many  :main_feeds, :as => :main
  has_many :feed_photos
  
  after_save :create_main_feed
  after_save :create_tag
  after_destroy :destroy_main_feed
  
  accepts_nested_attributes_for :feed_photos, reject_if: :feed_photos_attributes.blank?#, allow_destroy: true
  
  def self.chk_tag(content_line)
    if content_line.index("#")
      arr_tag = content_line.split(" ")[0]
      arr_tag = arr_tag.split("#")
      arr_tag.delete_at(0)
    end
    arr_tag
  end
  
  def create_main_feed
    self.main_feeds.create(user_id: self.user_id, sub_type: CONTENT)
  end
  
  def create_tag
    arr_content = self.content.split("\r\n")
    arr_tag = []
    arr_content.each do |content_line|
      ret_tag = Feed.chk_tag(content_line)
      if ret_tag
        arr_tag += ret_tag
      end
    end
    unless arr_tag.blank?
      arr_tag.uniq!
      arr_tag.each do |tag|
        FeedTag.create(feed_id: self.id, tag_name: tag)
      end
    end
  end
  
  
  
  def destroy_main_feed
    self.main_feeds.where(sub_type: CONTENT, user_id: self.user_id).destroy_all
    likes = self.likes
    if likes
      likes.destroy_all
    end
  end
end
