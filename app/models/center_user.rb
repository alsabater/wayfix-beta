class CenterUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :center
end
