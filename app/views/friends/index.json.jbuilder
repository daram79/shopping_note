json.array!(@recommend_users) do |recommend_user|
  json.extract! recommend_user, :id, :nick
  json.profile_img recommend_user.profile_photos.last
  
  feeds = recommend_user.feeds.limit(3)
  feed_img = []
  feeds.each do |feed|
    feed_img.push feed.feed_photos.last
  end
  json.feed_img feed_img
end
