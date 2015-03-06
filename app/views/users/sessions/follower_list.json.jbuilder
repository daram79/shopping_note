json.array!(@followers) do |follower|
	json.extract! follower, :id, :nick
	json.profile_image follower.profile_photos[0]
end