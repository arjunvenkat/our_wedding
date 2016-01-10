class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :household_id
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
