class Client < ActiveRecord::Base
	belongs_to :admin
	has_many :centers
	has_many :users
end
