class Guest < ActiveRecord::Base
  belongs_to :household
  has_many :rsvps

  def full_name
    return "#{first} #{last}"
  end

  scope :has_full_name, -> { where("first <> '' AND last <> ''") }
end
