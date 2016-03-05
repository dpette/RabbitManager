json.array!(@pregnancies) do |pregnancy|
  json.extract! pregnancy, :id, :starting_at, :ending_at, :rabbit_id
  json.url pregnancy_url(pregnancy, format: :json)
end
