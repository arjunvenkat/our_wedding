class AddFirstAndLastNameToHousehold < ActiveRecord::Migration
  def change
    add_column :households, :first, :string
    add_column :households, :last, :string
  end
end
