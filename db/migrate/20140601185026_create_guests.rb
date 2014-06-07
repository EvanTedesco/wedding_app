class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :user_id
      t.index :user_id
      t.integer :food_id
    end
  end
end
