class Household < ActiveRecord::Base
  paginates_per 30
  has_many :guests, -> { order(position: :asc) }, dependent: :destroy
  has_many :rsvps, through: :guests
  default_scope { order('last ASC') }
  scope :replied, -> { where.not(replied_at: nil) }
  scope :need_to_reply, -> { where.not(id: nil) - replied }
  scope :by_category, -> (category) {
    household_ids = Guest.where(category: category).pluck(:household_id)
    Household.where(id: household_ids)
  }

  def name
    last
  end

  def full_name
    "#{last}, #{first} "
  end

  def replied?
    replied_at == nil ? false : true
  end

  def days_since_first_reply
    replied? ? ((Time.now - replied_at)/1.day).floor : nil
  end

  def can_edit_rsvp?
    replied? == false || days_since_first_reply < 7
  end

end
