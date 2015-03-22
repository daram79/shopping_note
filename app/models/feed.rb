class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_type
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # has_one  :main_feed, :as => :main
  has_many :feed_photos, :dependent => :destroy
  has_many :feed_tags, :dependent => :destroy
  # after_save :create_main_feed
  after_save :create_tag
  # after_destroy :destroy_main_feed
  
  accepts_nested_attributes_for :feed_photos, reject_if: :feed_photos_attributes.blank?#, allow_destroy: true
  
  def self.chk_tag(content_line)
    arr_tag = []
    if content_line.index("#")
      arr_line = content_line.split(" ")
      arr_line.each do |val|
        arr_tag.push val if val.index("#")
      end
    end
    arr_tag
  end
  
  # def create_main_feed
    # self.main_feeds.create(user_id: self.user_id, sub_type: CONTENT)
  # end
  
  def create_tag
    content = self.content.gsub(/(\r\n|\r|\n)/, " ") #개행삭제
    # arr_content = self.content.split("\r\n")
    ret_tag = Feed.chk_tag(content)
    unless ret_tag.blank?
      ret_tag.uniq!
      ret_tag.each do |tag|
        tag.gsub!('#', '')
        FeedTag.create(feed_id: self.id, tag_name: tag)
      end
    end
  end
  
  
  
  # def destroy_main_feed
    # self.main_feeds.where(sub_type: CONTENT, user_id: self.user_id).destroy_all
    # likes = self.likes
    # if likes
      # likes.destroy_all
    # end
  # end
end
