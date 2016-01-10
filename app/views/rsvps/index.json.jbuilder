json.array!(@rsvps) do |rsvp|
  json.extract! rsvp, :id, :guest_id, :event_id, :status
  json.url rsvp_url(rsvp, format: :json)
end
