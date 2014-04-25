class CreateRsvp < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name
      t.boolean :attending
      t.boolean :guest
    end
  end
end
