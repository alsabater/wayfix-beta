class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :admin_id
      t.integer :client_id
      t.string :center_name
      t.integer :patient_id
      t.string :patient_name
      t.string :patient_surname
      t.integer :patient_age
      t.string :observation
      t.string :reason
      t.date :date
      t.time :hour_minute
      t.integer :wait_time
      t.integer :visit_time
      t.integer :total_time
      t.time :start_time
      t.integer :duration
      t.time :finish_time
      t.string :arrival_time
      t.string :entry_time
      t.string :exit_time
      t.string :doctor_name
      t.string :doctor_surname

      # This is for creating patients through the new event modal
      t.date :patient_birthday
      t.string :patient_phone_number_1
      t.string :patient_email
      t.integer :patient_history
      t.string :patient_insurance

      t.timestamps null: false
    end
  end
end
