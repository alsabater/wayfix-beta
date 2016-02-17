class CreateCenterUsers < ActiveRecord::Migration
  def change
    create_table :center_users do |t|
      t.integer :user_id
      t.integer :center_id
      t.timestamps null: false
    end
  end
end
