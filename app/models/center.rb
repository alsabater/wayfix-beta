class Center < ActiveRecord::Base
	belongs_to :client
	belongs_to :admin
    has_many :users
end
