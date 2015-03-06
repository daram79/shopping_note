json.array!(@followings) do |following|
	json.extract! following, :id, :nick
	json.profile_image following.profile_photos[0]
end