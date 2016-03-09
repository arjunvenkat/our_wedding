class Rsvp < ActiveRecord::Base
  belongs_to :guest
  acts_as_list scope: :guest
  belongs_to :event

  def readable_status
    status == "yes" ? "Is attending" : "Is not attending"
  end
end
