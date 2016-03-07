class AddPositionToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :position, :integer
  end
end
