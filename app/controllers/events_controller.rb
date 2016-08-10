class EventsController < ApplicationController	
	def index
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def day
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@events = Event.where(date: params[:date])
		@users = User.all
	end

	def month
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user.id
		@event.client_id = current_user.client_id
		if @event.save
			respond_to do |format|
			    format.html { redirect_to events_path } #or wherever you want to redirect
			    format.js {} #this will render create.js.erb
			end
		else
			flash.now[:alert] = "No se ha podido crear el evento"
		end
	end

	def update
		@event = Event.find(params[:id])
	 		if @event.update_attributes(event_params)
				respond_to do |format|
				    format.html { render nothing: true, status: 200 } #or wherever you want to redirect
		 			puts("Evento actualizado!")
		 		end
	 		else
				flash.now[:alert] = "No se ha podido actualizar el evento"
	  		end
	end

	private

	def event_params
		params.require(:event).permit!
	end
end

