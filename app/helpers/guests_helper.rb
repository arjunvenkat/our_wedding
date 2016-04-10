module GuestsHelper
  def rsvp_status(guest, event)
    event_rsvp = guest.rsvps.find_by(event_id: event.id)
    if event_rsvp.present?
      if guest.household.replied_at != nil
        if event_rsvp.status == "yes"
          return raw('<i class="fa fa-check attending"></i>')
        else
          return  raw('<i class="fa fa-times not-attending"></i>')
        end
      else
        return  raw('<i class="fa fa-question maybe-attending"></i>')
      end
    end
  end
end
