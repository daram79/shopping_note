json.array!(@comments) do |comment|
  json.extract! comment, :id, :content 
  json.user_name comment.user.nick
  json.profile_image comment.user.profile_photos.last
end