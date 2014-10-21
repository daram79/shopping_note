json.array!(@feeds) do |feed|
  json.extract! feed, :id, :user_id, :content
  json.user feed.user
  json.profile_photo feed.user.profile_photos[0]
  json.feed_photo feed.feed_photos[0]
  json.like_count feed.likes.count
  json.current_user_id current_user.id
end
