class DeleteGuestMealChoice < ActiveRecord::Migration
  def change
    drop_table :guest_meal_choices
    add_column :guests, :food_id, :integer
  end
end
