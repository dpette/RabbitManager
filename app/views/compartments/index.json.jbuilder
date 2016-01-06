json.array!(@compartments) do |compartment|
  json.extract! compartment, :id
  json.url compartment_url(compartment, format: :json)
end
