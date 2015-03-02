json.array!(@users) do |user|
  json.extract! user, :id, :nick
  json.profile_img user.profile_photos.last
  
  feeds = user.feeds.limit(3)
  feed_img = []
  feeds.each do |feed|
    feed_img.push feed.feed_photos.last
  end
  json.feed_img feed_img
end
