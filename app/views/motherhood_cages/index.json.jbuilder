json.array!(@motherhood_cages) do |motherhood_cage|
  json.extract! motherhood_cage, :id
  json.url motherhood_cage_url(motherhood_cage, format: :json)
end
