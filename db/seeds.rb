# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Household.destroy_all
h1 = Household.create(name: "The Venkataswamys")
h2 = Household.create(name: "The Goels")
puts "There are #{Household.count} households in the database"

Guest.destroy_all
g1 = Guest.create(
      first: "Arjun",
      last: "Venkataswamy",
      email: "avenkat2@gmail.com",
      household_id: h1.id)
g2 = Guest.create(
      first: "Suman",
      last: "Venkataswamy",
      email: "svenkat45@gmail.com",
      household_id: h1.id)
g3 = Guest.create(
      first: "Kriti",
      last: "Goel",
      email: "kgoel18@gmail.com",
      household_id: h2.id)
puts "There are #{Guest.count} guests in the database"

Event.destroy_all
e1 = Event.create(
      name: "Sangeet",
      description: "Dancing and whatnot",
      datetime: DateTime.strptime("06/09/2016 19:30", "%m/%d/%Y %H:%M"),
      address1: "1620 75th St",
      city: "Downers Grove",
      state: "IL",
      zip: "60516")
puts "There are #{Event.count} events in the database"

Rsvp.destroy_all
r1 = Rsvp.create(guest_id: g1.id, event_id: e1.id, status: "yes")
r2 = Rsvp.create(guest_id: g2.id, event_id: e1.id, status: "no")
r3 = Rsvp.create(guest_id: g3.id, event_id: e1.id, status: "not replied")
puts "There are #{Rsvp.count} rsvps in the database"
