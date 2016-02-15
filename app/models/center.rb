class Center < ActiveRecord::Base
	belongs_to :client
	has_many :center_users
	has_many :users, through: :center_users
end
