class Household < ActiveRecord::Base
  has_many :guests, -> { order(position: :asc) }
  has_many :rsvps, through: :guests

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
