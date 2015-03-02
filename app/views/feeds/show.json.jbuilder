json.extract! @feed, :id, :content, :created_at, :updated_at
json.user @feed.user
json.profile_photo @feed.user.profile_photos[0]
json.feed_photo @feed.feed_photos[0]
json.comment_count @feed.comments.count
json.like_count @feed.likes.count
if @feed.likes.find_by_user_id(current_user.id)
  json.is_like true
else
  json.is_like false
end