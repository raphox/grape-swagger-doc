class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :user
      t.references :address

      t.string :username
      t.text :text
      t.string :ip
      t.string :phone

      t.timestamps null: false
    end
  end
end
