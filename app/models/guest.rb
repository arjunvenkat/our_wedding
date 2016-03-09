class Guest < ActiveRecord::Base
  belongs_to :household
  acts_as_list scope: :household
  has_many :rsvps, -> { order(position: :asc) }

  def full_name
    return "#{salutation} #{first} #{last}"
  end

  scope :has_full_name, -> { where("first <> '' AND last <> ''") }
end
