class AddCategoryToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :category, :string
  end
end
