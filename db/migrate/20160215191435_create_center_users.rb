class CreateCenterUsers < ActiveRecord::Migration
  def change
    create_table :center_users do |t|

      t.timestamps null: false
    end
  end
end
