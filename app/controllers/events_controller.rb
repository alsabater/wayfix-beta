class EventsController < ApplicationController	
	before_action :authenticate_user_or_admin!

	def index
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def day
		@user = select_user
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@events = Event.where(client_id: @user.client_id, date: params[:date])
		@users = User.all
	end

	def month
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@events = Event.where(client_id: select_user.client_id)
		@morning_events = @events.where(hour_minute: '2000-01-01 00:00'..'2000-01-01 14:30')
		@afternoon_events = @events.where(hour_minute: '2000-01-01 14:30'..'2000-01-02 00:00')
		@reason_m_new = @morning_events.where(reason: 'Nuevo')
		@reason_m_surgery = @morning_events.where(reason: 'Cirugía')
		@reason_m_review = @morning_events.where(reason: 'Revisión')
		@reason_a_new = @afternoon_events.where(reason: 'Nuevo')
		@reason_a_surgery = @afternoon_events.where(reason: 'Cirugía')
		@reason_a_review = @afternoon_events.where(reason: 'Revisión')
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = select_user.id
		@event.client_id = select_user.client_id
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

