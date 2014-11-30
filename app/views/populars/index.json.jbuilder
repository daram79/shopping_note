json.array!(@populars) do |popular|
  json.extract! popular, :id
  json.url popular_url(popular, format: :json)
end
