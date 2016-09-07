class EventsController < ApplicationController	
	before_action :authenticate_user_or_admin!


	def index
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def day
		@user = select_user
		@centers = Center.where(client_id: @user.client_id)
		@users = User.where(["client_id = ? and job_position = ?", @user.client_id, "Personal Médico"]) + Admin.where(["client_id = ?", @user.client_id])
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@event = Event.new
	end

	def day_filter
		@user = select_user
		@events = Event.where(client_id: @user.client_id, date: params[:date], center_name: params[:center_name], doctor_name: params[:doctors].select{|key, hash| hash == "true" }.keys).order('hour_minute')
		respond_to do |format|
			format.json { render json: @events }
		end	
	end

	def month_filter
		@user = select_user
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@events = Event.where(client_id: @user.client_id, center_name: params[:center_name], doctor_name: params[:doctors].select{|key, hash| hash == "true" }.keys).order('hour_minute')
		@morning_events = @events.where(hour_minute: '2000-01-01 00:00'..'2000-01-01 14:30')
		@afternoon_events = @events.where(hour_minute: '2000-01-01 14:30'..'2000-01-02 00:00')
		respond_to do |format|
			format.html { render partial: 'month_calendar' }
		end
	end

	def month
		@user = select_user
		@centers = Center.where(client_id: @user.client_id)
		@users = User.where(["client_id = ? and job_position = ?", @user.client_id, "Personal Médico"]) + Admin.where(["client_id = ?", @user.client_id])
		@event = Event.new
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def new
		@user = select_user
		@event = Event.new
		@patients = Patient.where(client_id: @user.client_id)
		if params[:term]
			@patient = @patients.where("name || ' ' || surname LIKE :search" , search: "%#{params[:term]}%")
		else
			@patient = Patient.new
		end
		respond_to do |format|  
			format.json { render :json => @patient.to_json }
		end
	end

	def create
		@user = select_user
		@event = Event.new(event_params)
		@patients = Patient.where(client_id: select_user.client_id)
		@patient = @patients.find_by(["name @@ ? and surname @@ ?", params[:event][:patient_name], params[:event][:patient_surname]])
		if @patient == nil
			@patient = Patient.new
			@patient.client_id = @user.client_id
			@patient.name = params[:event][:patient_name]
			@patient.surname = params[:event][:patient_surname]
			@patient.birthday = params[:event][:patient_birthday]
			@patient.phone_number_1 = params[:event][:patient_phone_number_1]
			@patient.email = params[:event][:patient_email]
			@patient.history = history_number(@user)
			@patient.insurance = params[:event][:patient_insurance]
			if @patient.save
				flash.now[:success] = "Se ha añadido un nuevo paciente"
			else
				flash.now[:danger] = "No se ha podido añadir al nuevo paciente"
				redirect_to events_month_path
			end
		end
		@event.start_time = params[:event][:hour_minute]
		@event.patient_age = (Date.today - params[:event][:patient_birthday].to_date).fdiv(365).to_i
		@event.patient_insurance = @patient.insurance
		@event.patient_history = @patient.history
		@event.client_id = @user.client_id
		if @event.save
			@user.events << @event
			@patient.events << @event
			redirect_to events_day_path(date: params[:event][:date])
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

	def patient_params
		params.require(:patient).permit(:name, :surname, :email, :birthday, :phone_number_1, :client_id, :insurance)
	end

	def history_number user
		number = Patient.where(client_id: user.client_id).size
		number += 1
	end
end

