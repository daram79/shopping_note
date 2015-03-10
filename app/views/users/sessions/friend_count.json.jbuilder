json.following_count @user.user_relations.count
json.follower_count @user.friend_user_relations.count
json.content_count @user.feeds.count
