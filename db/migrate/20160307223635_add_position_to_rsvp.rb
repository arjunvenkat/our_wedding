class AddPositionToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :position, :integer
  end
end
