class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_type
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # has_one  :main_feed, :as => :main
  has_many :feed_photos, :dependent => :destroy
  has_many :feed_tags, :dependent => :destroy
  # after_save :create_main_feed
  # after_save :create_tag
  # after_destroy :destroy_main_feed
  
  accepts_nested_attributes_for :feed_photos, reject_if: :feed_photos_attributes.blank?#, allow_destroy: true
  
  def self.make_tag(content_line)
    arr_tag = []
    if content_line.index("#")
      arr_line = content_line.split(" ")
      arr_line.each do |val|
        arr_tag.push val if val.index("#")
      end
    end
    ret_arr = arr_tag.uniq
  end
  
  # def create_main_feed
    # self.main_feeds.create(user_id: self.user_id, sub_type: CONTENT)
  # end
  
  def self.get_tag(content)
    content = content.gsub(/(\r\n|\r|\n)/, " ") #개행삭제
    Feed.make_tag(content)
  end
  
  def self.create_tag(id, tags)
    tags.each do |tag|
      _tag = tag.gsub('#', '')
      FeedTag.create(feed_id: id, tag_name: _tag)
    end
  end
  
  def self.make_html(content, tags)
    html_content = content.clone
    html_content.gsub!(" ", "&nbsp;") #개행삭제
    html_content.gsub!(/(\r\n|\r|\n)/, "<br />")
    tags.each do |tag|
      _tag = tag.gsub('#', '')
      html_content.gsub!(tag, " <b><a href='search://#{_tag}'>#{tag}</a></b>")
    end
    html_content
  end
  
  
  
  # def destroy_main_feed
    # self.main_feeds.where(sub_type: CONTENT, user_id: self.user_id).destroy_all
    # likes = self.likes
    # if likes
      # likes.destroy_all
    # end
  # end
end
