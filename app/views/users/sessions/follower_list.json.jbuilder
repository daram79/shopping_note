json.array!(@followers) do |follower|
	json.extract! follower, :id, :nick
	json.profile_image follower.profile_photos[0]
	json.my_following_user_ids @my_following_user_ids
end