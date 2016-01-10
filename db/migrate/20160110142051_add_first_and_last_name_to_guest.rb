class AddFirstAndLastNameToGuest < ActiveRecord::Migration
  def change
    remove_column :guests, :name, :string
    add_column :guests, :first, :string
    add_column :guests, :last, :string
  end
end
