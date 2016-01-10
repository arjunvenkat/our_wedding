class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :guest_id
      t.integer :event_id
      t.string :status

      t.timestamps null: false
    end
  end
end
