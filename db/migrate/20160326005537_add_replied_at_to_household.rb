class AddRepliedAtToHousehold < ActiveRecord::Migration
  def change
    add_column :households, :replied_at, :datetime
  end
end
