class AddCentersUsersTable < ActiveRecord::Migration
  def change
  	create_table :centers_users, id: false do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :center, index: true
  	end
  end
end
