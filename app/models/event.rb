class Event < ActiveRecord::Base
	belongs_to :admin	
	belongs_to :user
	belongs_to :patient
end
