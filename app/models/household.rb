class Household < ActiveRecord::Base
  has_many :guests, -> { order(position: :asc) }
  has_many :rsvps, through: :guests
end
