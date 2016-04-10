class Guest < ActiveRecord::Base
  paginates_per 30
  belongs_to :household
  acts_as_list scope: :household
  has_many :rsvps, -> { order(position: :asc) }, dependent: :destroy
  default_scope { order('last ASC, first ASC') }
  # scope :replied_ids, -> { where(household_id: Household.replied_ids) }

  def full_name
    if salutation.present?
      return "#{salutation} #{first} #{last}"
    else
      return "#{first} #{last}"
    end
  end

  scope :has_full_name, -> { where("first <> '' AND last <> ''") }
end
