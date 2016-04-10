class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :guests, through: :rsvps
  def rsvps_for_household(household_id)
    guests.where(household_id: household_id).map {
      |guest| Rsvp.find_by(guest_id: guest.id, event_id: id)
    }
  end
  def attending_guests
    guests.joins(:rsvps).where('rsvps.status' => 'yes')
  end

  def replied_rsvps
    replied_household_ids = Household.replied.pluck(:id)
    replied_guest_ids = Guest.where(household_id: replied_household_ids).pluck(:id)
    Rsvp.where(guest_id: replied_guest_ids, event_id: id)
  end

  def unreplied_rsvps
    unreplied_household_ids = Household.not_replied.pluck(:id)
    unreplied_guest_ids = Guest.where(household_id: unreplied_household_ids).pluck(:id)
    Rsvp.where(guest_id: unreplied_guest_ids, event_id: id)
  end
end
