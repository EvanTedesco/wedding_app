class CreateWeddingParty < ActiveRecord::Migration
  def change
    create_table :wedding_parties do |t|
      t.string :groomsmen
      t.string :bridesmaids

    end
  end
end
