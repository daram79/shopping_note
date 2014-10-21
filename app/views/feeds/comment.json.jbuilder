json.array!(@comments) do |comment|
  json.extract! comment, :id
  json.user comment.user, :id, :nick
  json.profile_photo comment.user.profile_photos[0]
end