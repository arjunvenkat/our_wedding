json.array!(@guests) do |guest|
  json.extract! guest, :id, :household_id, :name, :email
  json.url guest_url(guest, format: :json)
end
