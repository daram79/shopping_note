json.array!(@alrams) do |alram|
  json.extract! alram, :id, :alram_type, :created_at
  json.friend_user alram.friend_user
  json.friend_profile_photo alram.friend_user.profile_photos[0]
  
  if alram.alram_type == "UserRelation"
  	json.my_following_user_ids @my_following_user_ids	
  else
  	json.feed_photo alram.alram.feed.feed_photos.first
  end
  json.url alram_url(alram, format: :json)
end
