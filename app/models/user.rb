class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :feeds
  has_many :user_relations
  has_many :be_requested_friends
  has_many :profile_photos
  has_many :comments
  accepts_nested_attributes_for :profile_photos, reject_if: :profile_photos_attributes.blank?, allow_destroy: true
  
  def with_profile_photo
    self.profile_photos.build
    self
  end
  
  #attr_accessor :image
  #after_create :create_image
  
  # private
  # def create_image
    # ProfilePhoto.create(user_id: self.id, image: self.image)
  # end
end
