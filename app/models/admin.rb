class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  		 :rememberable, :trackable, :validatable

  has_one :client
  has_many :centers
  has_many :events
end
