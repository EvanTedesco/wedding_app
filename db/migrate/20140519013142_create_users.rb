class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :admin
      t.boolean :attending
      t.integer :max_guests
      t.integer :number_of_guests
      t.integer :food_id
      t.string :comments
      t.string :auth_token
    end
  end
end
