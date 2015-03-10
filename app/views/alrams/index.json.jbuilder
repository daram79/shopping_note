json.array!(@alrams) do |alram|
  json.extract! alram, :id
  json.url alram_url(alram, format: :json)
end
