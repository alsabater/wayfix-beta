class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.integer :client_id
      t.integer :admin_id
      t.string :center_name
      t.string :address
      t.string :city
      t.string :province
      t.string :zip_code
      t.string :country
      t.string :phone_number_1
      t.string :phone_number_2
      t.string :fax_number
      t.string :email
      t.string :language
      t.string :currency
      t.timestamps null: false
    end
  end
end
