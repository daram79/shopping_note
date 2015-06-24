json.array!(@recommend_users) do |recommend_user|
  json.extract! recommend_user, :id, :nick
  json.profile_photo recommend_user.profile_photos[0]
end