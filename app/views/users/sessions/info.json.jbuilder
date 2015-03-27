json.extract! @user, :nick, :birthday, :uid
json.profile_image @user.profile_photos[0]
json.following_count @user.user_relations.count
json.follower_count @user.friend_user_relations.count
json.content_count @user.feeds.count
