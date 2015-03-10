json.array!(@followings) do |following|
	json.extract! following, :id, :nick
	json.profile_image following.profile_photos[0]
	json.my_following_user_ids @my_following_user_ids
end