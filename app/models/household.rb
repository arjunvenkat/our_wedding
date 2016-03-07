class Household < ActiveRecord::Base
  has_many :guests
  has_many :rsvps, through: :guests
end
