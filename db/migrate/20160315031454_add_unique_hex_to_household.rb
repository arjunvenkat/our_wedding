class AddUniqueHexToHousehold < ActiveRecord::Migration
  def change
    add_column :households, :unique_hex, :string
  end
end
