# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Household.destroy_all
h1 = Household.create(name: "Venkataswamy")
h2 = Household.create(name: "Goel")
puts "There are #{Household.count} households in the database"

Guest.destroy_all
g1 = Guest.create(
      salutation: "Mr",
      first: "Arjun",
      last: "Venkataswamy",
      email: "avenkat2@gmail.com",
      household_id: h1.id)
g2 = Guest.create(
      salutation: "Mr",
      first: "Suman",
      last: "Venkataswamy",
      email: "svenkat45@gmail.com",
      household_id: h1.id)
g3 = Guest.create(
      salutation: "Ms",
      first: "Kriti",
      last: "Goel",
      email: "kgoel18@gmail.com",
      household_id: h2.id)
g4 = Guest.create(
      salutation: "",
      first: "",
      last: "Goel",
      email: "",
      household_id: h2.id)
puts "There are #{Guest.count} guests in the database"

Event.destroy_all
e1 = Event.create(
      name: "Sangeet",
      description: "Dancing and whatnot",
      datetime: DateTime.strptime("06/09/2016 19:30", "%m/%d/%Y %H:%M"),
      address1: "Ashyana Banquets",
      address2: "1620 75th St",
      city: "Downers Grove",
      state: "IL",
      zip: "60516")
e2 = Event.create(
      name: "Wedding Ceremony",
      description: "This is where the wedding happens",
      datetime: DateTime.strptime("06/11/2016 10:30", "%m/%d/%Y %H:%M"),
      address1: "The Westin Chicago Northwest",
      address2: "400 Park Blvd",
      city: "Itasca",
      state: "IL",
      zip: "60143")
puts "There are #{Event.count} events in the database"

Rsvp.destroy_all
r1 = Rsvp.create(guest_id: g1.id, event_id: e1.id, status: "yes")
r2 = Rsvp.create(guest_id: g2.id, event_id: e1.id, status: "yes")
r3 = Rsvp.create(guest_id: g3.id, event_id: e1.id, status: "yes")
r4 = Rsvp.create(guest_id: g4.id, event_id: e1.id, status: "yes")
r5 = Rsvp.create(guest_id: g1.id, event_id: e2.id, status: "yes")
puts "There are #{Rsvp.count} rsvps in the database"
