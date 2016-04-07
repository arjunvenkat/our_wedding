require 'csv'
namespace :import do
  desc "Imports event guest data from a CSV"
  task guests: :environment do
    sangeet = Event.find_by(name: EVENTS[:sangeet])
    ceremony = Event.find_by(name: EVENTS[:ceremony])
    rehearsal_dinner = Event.find_by(name: EVENTS[:rehearsal_dinner])
    reception = Event.find_by(name: EVENTS[:reception])

    CSV.foreach("#{Rails.root}/db/data/master-guest-list.csv", headers: true) do |row|
      existing_household = Household.find_by(first: row[7].try(:strip), last: row[8].try(:strip))
      household = existing_household || Household.new({
          first: row[7].try(:strip),
          last: row[8].try(:strip)
        })
      unless household.id.present?
        hex = ""
        loop do
          hex = SecureRandom.hex(6)
          break if Household.find_by(unique_hex: hex).blank?
        end
        household.unique_hex = hex
        household.save
      end
      existing_guest = Guest.find_by({
        first: row[1].try(:strip),
        last: row[2].try(:strip),
        email: row[10].try(:strip),
        household_id: household.id
      })
      guest = existing_guest || Guest.create({
        salutation: row[0].try(:strip),
        first: row[1].try(:strip),
        last: row[2].try(:strip),
        email: row[9].try(:strip),
        category: row[10].try(:strip),
        household_id: household.id
        })
      print "#{household.full_name} - #{guest.full_name}\n"
      ceremony_rsvp = Rsvp.find_by(guest_id: guest.id, event_id: ceremony.id)
      Rsvp.create(guest_id: guest.id, event_id: ceremony.id, status: "yes") if ceremony_rsvp.blank? && row[3].present?
      reception_rsvp = Rsvp.find_by(guest_id: guest.id, event_id: reception.id)
      Rsvp.create(guest_id: guest.id, event_id: reception.id, status: "yes") if reception_rsvp.blank? && row[4].present?
      sangeet_rsvp = Rsvp.find_by(guest_id: guest.id, event_id: sangeet.id)
      Rsvp.create(guest_id: guest.id, event_id: sangeet.id, status: "yes") if sangeet_rsvp.blank? && row[5].present?
      rehearsal_dinner_rsvp = Rsvp.find_by(guest_id: guest.id, event_id: rehearsal_dinner.id)
      Rsvp.create(guest_id: guest.id, event_id: rehearsal_dinner.id, status: "yes") if rehearsal_dinner_rsvp.blank? && row[6].present?

    end
    puts "There are #{Household.count} households in the database"
    puts "There are #{Guest.count} guests in the database"
  end
end
