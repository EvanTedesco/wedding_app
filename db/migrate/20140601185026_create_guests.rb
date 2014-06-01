class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :guest_id
      t.index :guest_id
      t.integer :food_id
    end
  end
end
