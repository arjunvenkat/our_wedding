class Rsvp < ActiveRecord::Base
  paginates_per 30
  validates :guest_id,
            :event_id, presence: true

  belongs_to :guest
  acts_as_list scope: :guest
  belongs_to :event

  scope :attending, -> { where(status: "yes") }
  scope :not_attending, -> { where.not(status: "yes") }

  def readable_status
    if guest.household.replied_at != nil
      status == "yes" ? "is attending" : "is not attending"
    else
      "might be attending"
    end
  end


end
