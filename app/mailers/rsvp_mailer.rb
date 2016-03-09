class RsvpMailer < ApplicationMailer
  def update(household)
      @household = household
      @household.guests do |guest|
        logger.debug guest.inspect
        # mail(to: guest.email, subject: "Updated RSVP for Kriti and Arjun's wedding") if guest.email.present?
      end
    end
end
