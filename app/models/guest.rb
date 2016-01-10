class Guest < ActiveRecord::Base
  def full_name
    return "#{first} #{last}"
  end

  scope :has_full_name, -> { where("first <> '' AND last <> ''") }
end
