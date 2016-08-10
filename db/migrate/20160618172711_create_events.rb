class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :client_id
      t.integer :patient_id
      t.string :patient_name
      t.string :patient_surname
      t.string :observation
      t.string :reason
      t.date :date
      t.time :hour_minute
      t.time :start_time
      t.integer :wait_time
      t.integer :total_time
      t.time :finish_time
      t.string :doctor_name
      t.string :doctor_surname
      t.timestamps null: false
    end
  end
end
