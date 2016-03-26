module HouseholdsHelper
  def changing_rsvp_info(household)
    message = ""
    if household.replied?
      if household.can_edit_rsvp?
        message = "You have #{pluralize(7 - household.days_since_first_reply, 'day')} left to make changes to your rsvp. If you still need to make changes afterwards,"
      else
        message = "Your RSVP status has been finalized. If you still need to make changes, "
      end
    else
      message = "You have a week to make changes once you've submitted your RSVP. If you still need to make changes afterwards,"
    end
    return raw("#{message} please email Arjun at #{content_tag(:a, "avenkat2@gmail.com", href: "avenkat2@gmail.com")}")
  end
end
