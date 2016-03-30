require 'csv'
namespace :import do
  desc "Imports event guest data from a CSV"
  task guests: :environment do
    sangeet = Event.find_by(name: EVENTS[:sangeet])
    ceremony = Event.find_by(name: EVENTS[:ceremony])
    rehearsal_dinner = Event.find_by(name: EVENTS[:rehearsal_dinner])
    reception = Event.find_by(name: EVENTS[:reception])
    CSV.foreach("#{Rails.root}/db/data/kriti-arjun-guests.csv", headers: true) do |row|
      existing_household = Household.find_by(first: row[6].try(:strip), last: row[7].try(:strip))
      household = existing_household || Household.new({
          first: row[6].try(:strip),
          last: row[7].try(:strip)
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
      print household.full_name
      existing_guest = Guest.find_by(first: row[0].try(:strip), last: row[1].try(:strip), email: row[9].try(:strip))
      guest = existing_guest || Guest.create({
          first: row[0].try(:strip),
          last: row[1].try(:strip),
          email: row[9].try(:strip),
          household_id: household.id
        })
      print " - #{guest.full_name}\n"
      Rsvp.find_or_create_by(guest_id: guest.id, event_id: ceremony.id) if row[2].present?
      Rsvp.find_or_create_by(guest_id: guest.id, event_id: reception.id) if row[3].present?
      Rsvp.find_or_create_by(guest_id: guest.id, event_id: sangeet.id) if row[4].present?
      Rsvp.find_or_create_by(guest_id: guest.id, event_id: rehearsal_dinner.id) if row[5].present?


    end
    puts "There are #{Household.count} guests in the database"
    puts "There are #{Guest.count} guests in the database"
  end
end
