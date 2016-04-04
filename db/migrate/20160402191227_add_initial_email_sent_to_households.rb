class AddInitialEmailSentToHouseholds < ActiveRecord::Migration
  def change
    add_column :households, :initial_email_sent, :boolean, default: false
  end
end
