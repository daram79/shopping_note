class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_type
  has_many :likes
  has_many :comments
  has_many :feed_photos
  
  accepts_nested_attributes_for :feed_photos, reject_if: :feed_photos_attributes.blank?#, allow_destroy: true
end
