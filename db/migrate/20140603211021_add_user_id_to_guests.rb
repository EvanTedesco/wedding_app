class AddUserIdToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :rsvp_id, :integer
    remove_column :guests, :guest_id, :integer
    remove_column :guests, :food_id, :integer
  end
end
