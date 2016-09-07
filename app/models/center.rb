class Center < ActiveRecord::Base
	belongs_to :client
	belongs_to :admin
    has_and_belongs_to_many :users
end
