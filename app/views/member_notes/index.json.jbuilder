json.array!(@member_notes) do |member_note|
  json.extract! member_note, :id
  json.url member_note_url(member_note, format: :json)
end