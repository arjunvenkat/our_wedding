# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Household.destroy_all
# h1 = Household.create(first: "Arjun", last: "Venkataswamy")
# h2 = Household.create(first: "Kriti", last: "Goel")
# h3 = Household.create(first: "Neal", last: "Dodia")
# h4 = Household.create(first: "Samarth", last: "Bhaskar")
# Household.all.each do |household|
#       hex = ""
#       loop do
#         hex = SecureRandom.hex(6)
#         break if Household.find_by(unique_hex: hex).blank?
#       end
#       household.unique_hex = hex
#       household.save
# end
# puts "There are #{Household.count} households in the database"

# Guest.destroy_all
# g1 = Guest.create(
#       salutation: "Mr.",
#       first: "Arjun",
#       last: "Venkataswamy",
#       email: "avenkat2@gmail.com",
#       position: 1,
#       household_id: h1.id,)
# g2 = Guest.create(
#       salutation: "Mr.",
#       first: "Rajeev",
#       last: "Goel",
#       email: "",
#       position: 2,
#       household_id: h2.id)
# g3 = Guest.create(
#       salutation: "Ms.",
#       first: "Kriti",
#       last: "Goel",
#       email: "",
#       position: 1,
#       household_id: h2.id)
# g4 = Guest.create(
#       salutation: "",
#       first: "",
#       last: "Goel",
#       email: "",
#       position: 2,
#       household_id: h2.id)
# g5 = Guest.create(
#       salutation: "Dr.",
#       first: "Neal",
#       last: "Dodia",
#       email: "ndodia2@gmail.com",
#       position: 1,
#       household_id: h3.id)
# g6 = Guest.create(
#       salutation: "Mr.",
#       first: "Samarth",
#       last: "Bhaskar",
#       email: "samarth.bhaskar@gmail.com",
#       position: 1,
#       household_id: h4.id)
# puts "There are #{Guest.count} guests in the database"

Event.destroy_all
e1 = Event.create(
      name: EVENTS[:sangeet],
      description: "Cocktails, followed by dinner and performances",
      datetime: DateTime.strptime("06/09/2016 19:30", "%m/%d/%Y %H:%M"),
      address1: "Ashyana Banquets",
      address2: "1620 75th St",
      city: "Downers Grove",
      state: "IL",
      zip: "60516",
      position: 1)
e2 = Event.create(
      name: EVENTS[:rehearsal_dinner],
      description: "A dinner for close friends and family of Kriti and Arjun",
      datetime: DateTime.strptime("06/10/2016 19:00", "%m/%d/%Y %H:%M"),
      address1: "DL Loft",
      address2: "3050 N Lincoln Ave",
      city: "Chicago",
      state: "IL",
      zip: "60657",
      position: 2)
e3 = Event.create(
      name: EVENTS[:ceremony],
      description: "The ceremony uniting Kriti and Arjun in marriage. The baraat begins at 9:30am and the ceremony begins at 10:30am",
      datetime: DateTime.strptime("06/11/2016 9:30", "%m/%d/%Y %H:%M"),
      address1: "The Westin Chicago Northwest",
      address2: "400 Park Blvd",
      city: "Itasca",
      state: "IL",
      zip: "60143",
      position: 3)
e4 = Event.create(
      name: EVENTS[:reception],
      description: "Cocktails followed by dinner, speeches and dancing",
      datetime: DateTime.strptime("06/11/2016 18:00", "%m/%d/%Y %H:%M"),
      address1: "The Westin Chicago Northwest",
      address2: "400 Park Blvd",
      city: "Itasca",
      state: "IL",
      zip: "60143",
      position: 4)
puts "There are #{Event.count} events in the database"

# Rsvp.destroy_all
# Rsvp.create(guest_id: g1.id, event_id: e1.id, status: "yes")
# Rsvp.create(guest_id: g2.id, event_id: e1.id, status: "yes")
# Rsvp.create(guest_id: g3.id, event_id: e1.id, status: "yes")
# Rsvp.create(guest_id: g4.id, event_id: e1.id, status: "yes")
# Rsvp.create(guest_id: g1.id, event_id: e2.id, status: "yes")
# Rsvp.create(guest_id: g3.id, event_id: e2.id, status: "yes")
# Rsvp.create(guest_id: g1.id, event_id: e3.id, status: "yes")
# Rsvp.create(guest_id: g3.id, event_id: e3.id, status: "yes")
# Rsvp.create(guest_id: g3.id, event_id: e4.id, status: "yes")
# Rsvp.create(guest_id: g5.id, event_id: e1.id, status: "yes")
# Rsvp.create(guest_id: g5.id, event_id: e2.id, status: "yes")
# Rsvp.create(guest_id: g5.id, event_id: e3.id, status: "yes")
# Rsvp.create(guest_id: g5.id, event_id: e4.id, status: "yes")
# Rsvp.create(guest_id: g6.id, event_id: e1.id, status: "yes")
# Rsvp.create(guest_id: g6.id, event_id: e2.id, status: "yes")
# Rsvp.create(guest_id: g6.id, event_id: e3.id, status: "yes")
# Rsvp.create(guest_id: g6.id, event_id: e4.id, status: "yes")
# puts "There are #{Rsvp.count} rsvps in the database"
