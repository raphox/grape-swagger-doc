class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
