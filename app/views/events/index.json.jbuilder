json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :datetime, :address1, :address2, :city, :state, :zip
  json.url event_url(event, format: :json)
end
