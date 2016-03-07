class AddStatusToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :status, :string, default: 'attending'
  end
end
