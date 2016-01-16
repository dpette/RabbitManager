json.array!(@fattenings) do |fattening|
  json.extract! fattening, :id
  json.url fattening_url(fattening, format: :json)
end
