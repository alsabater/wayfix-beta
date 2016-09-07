class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
  	  t.integer :client_id
  	  t.integer :center_id
  	  t.integer :user_id
      t.integer :admin_id
      t.string :name
      t.string :surname
      t.string :email
      t.string :insurance
      t.integer :history
      t.date :birthday
      t.string :phone_number_1
      t.string :phone_number_2
      t.string :genre
      t.timestamps null: false
    end
  end
end
