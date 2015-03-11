class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  acts_as_token_authenticatable
  
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  #devise :omniauthable
       
  has_many :feeds
  has_many :likes
  has_many :user_relations
  has_many :alrams
  has_many :friend_user_alrams, :foreign_key => "friend_user_id", :class_name => "Alram"
  has_many :friend_user_relations, :foreign_key => "friend_user_id", :class_name => "UserRelation"
  has_many :be_requested_friends
  has_many :profile_photos
  has_many :comments
  accepts_nested_attributes_for :profile_photos, reject_if: :profile_photos_attributes.blank?#, allow_destroy: true
  
  
  def self.from_omniauth(auth)
    token = auth["credentials"]["token"]
    graph = Koala::Facebook::API.new(token)
    where(auth.slice(:provider, :uid, :nick)).first_or_create do |user|
      user.email = auth.info.email
      user.nick = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.profile_photos.build(remote_image_url: graph.get_picture("me", :type => "large"))
    end
  end
  
  def with_profile_photo
    self.profile_photos.build
    self
  end
  
  # private
  # def create_image
    # ProfilePhoto.create(user_id: self.id, image: self.image)
  # end
end
