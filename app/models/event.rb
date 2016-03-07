class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :guests, through: :rsvps
  def rsvps_for_household(household_id)
    guests.where(household_id: household_id).map {
      |guest| Rsvp.find_by(guest_id: guest.id, event_id: id)
    }
  end
end
