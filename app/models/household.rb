class Household < ActiveRecord::Base
  paginates_per 30
  has_many :guests, -> { order(position: :asc) }, dependent: :destroy
  has_many :rsvps, through: :guests
  default_scope { order('last ASC') }
  scope :replied, -> { where.not(replied_at: nil) }
  scope :not_replied, -> { where(replied_at: nil) }
  scope :need_to_reply, -> { where.not(id: nil) - replied }
  scope :by_category, -> (category) {
    household_ids = Guest.where(category: category).pluck(:household_id)
    Household.where(id: household_ids)
  }
  # scope :replied_ids, -> { replied.pluck(:id) }

  def name
    last.present? ? last : first
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
