class Patient < ActiveRecord::Base
	belongs_to :client
	has_many :events
end
