json.array!(@comments) do |comment|
  json.extract! comment, :id, :content
  json.time_word @time_word[comment.id] 
  json.user_name comment.user.nick
  json.profile_image comment.user.profile_photos.last
end