class EventsController < ApplicationController
	def index
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@events = Event.all	
	end
end
