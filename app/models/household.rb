class Household < ActiveRecord::Base
  has_many :guests
end
