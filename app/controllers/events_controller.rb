class EventsController < ApplicationController	
	before_action :authenticate_user_or_admin!


	def index
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def activity_panel
		@time_array = ['00:00', '00:15', '00:30', '00:45', '01:00', '01:15', '01:30', '01:45', '02:00', '02:15', '02:30', '02:45', '03:00', '03:15', '03:30', '03:45', '04:00', '04:15', '04:30', '04:45', '05:00', '05:15', '05:30', '05:45', '06:00', '06:15', '06:30', '06:45', '07:00', '07:15', '07:30', '07:45', '08:00', '08:15', '08:30', '08:45', '09:00', '09:15', '09:30', '09:45', '10:00', '10:15', '10:30', '10:45', '11:00', '11:15', '11:30', '11:45', '12:00', '12:15', '12:30', '12:45', '13:00', '13:15', '13:30', '13:45', '14:00', '14:15', '14:30', '14:45', '15:00', '15:15', '15:30', '15:45', '16:00', '16:15', '16:30', '16:45', '17:00', '17:15', '17:30', '17:45', '18:00', '18:15', '18:30', '18:45', '19:00', '19:15', '19:30', '19:45', '20:00', '20:15', '20:30', '20:45', '21:00', '21:15', '21:30', '21:45', '22:00', '22:15', '22:30', '22:45', '23:00', '23:15', '23:30', '23:45']
		@user = select_user
		@centers = Center.where(client_id: @user.client_id)
		@users = User.where(["client_id = ? and job_position = ?", @user.client_id, "Personal Médico"]) + Admin.where(["client_id = ?", @user.client_id])
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@event = Event.new
	end

	def activity_panel_filter
		@user = select_user
		@events = Event.where(client_id: @user.client_id, date: params[:date], center_name: params[:center_name], doctor_name: params[:doctors].select{|key, hash| hash == "true" }.keys).order('start_time')
		respond_to do |format|
			format.json { render json: @events }
		end	
	end

	def month
		@time_array = ['00:00', '00:15', '00:30', '00:45', '01:00', '01:15', '01:30', '01:45', '02:00', '02:15', '02:30', '02:45', '03:00', '03:15', '03:30', '03:45', '04:00', '04:15', '04:30', '04:45', '05:00', '05:15', '05:30', '05:45', '06:00', '06:15', '06:30', '06:45', '07:00', '07:15', '07:30', '07:45', '08:00', '08:15', '08:30', '08:45', '09:00', '09:15', '09:30', '09:45', '10:00', '10:15', '10:30', '10:45', '11:00', '11:15', '11:30', '11:45', '12:00', '12:15', '12:30', '12:45', '13:00', '13:15', '13:30', '13:45', '14:00', '14:15', '14:30', '14:45', '15:00', '15:15', '15:30', '15:45', '16:00', '16:15', '16:30', '16:45', '17:00', '17:15', '17:30', '17:45', '18:00', '18:15', '18:30', '18:45', '19:00', '19:15', '19:30', '19:45', '20:00', '20:15', '20:30', '20:45', '21:00', '21:15', '21:30', '21:45', '22:00', '22:15', '22:30', '22:45', '23:00', '23:15', '23:30', '23:45']
		@user = select_user
		@centers = Center.where(client_id: @user.client_id)
		@users = User.where(["client_id = ? and job_position = ?", @user.client_id, "Personal Médico"]) + Admin.where(["client_id = ?", @user.client_id])
		@event = Event.new
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def month_filter
		@user = select_user
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@events = Event.where(client_id: @user.client_id, center_name: params[:center_name], doctor_name: params[:doctors].select{|key, hash| hash == "true" }.keys).order('start_time')
		@morning_events = @events.where(start_time: Time.zone.parse('0:00').strftime("%H:%M")..Time.zone.parse('14:30').strftime("%H:%M"))
		binding.pry
		@afternoon_events = @events.where(start_time: '14:30'..'00:00')
		respond_to do |format|
			format.html { render partial: 'month_calendar' }
		end
	end

	def day
		@time_array = ['00:00', '00:15', '00:30', '00:45', '01:00', '01:15', '01:30', '01:45', '02:00', '02:15', '02:30', '02:45', '03:00', '03:15', '03:30', '03:45', '04:00', '04:15', '04:30', '04:45', '05:00', '05:15', '05:30', '05:45', '06:00', '06:15', '06:30', '06:45', '07:00', '07:15', '07:30', '07:45', '08:00', '08:15', '08:30', '08:45', '09:00', '09:15', '09:30', '09:45', '10:00', '10:15', '10:30', '10:45', '11:00', '11:15', '11:30', '11:45', '12:00', '12:15', '12:30', '12:45', '13:00', '13:15', '13:30', '13:45', '14:00', '14:15', '14:30', '14:45', '15:00', '15:15', '15:30', '15:45', '16:00', '16:15', '16:30', '16:45', '17:00', '17:15', '17:30', '17:45', '18:00', '18:15', '18:30', '18:45', '19:00', '19:15', '19:30', '19:45', '20:00', '20:15', '20:30', '20:45', '21:00', '21:15', '21:30', '21:45', '22:00', '22:15', '22:30', '22:45', '23:00', '23:15', '23:30', '23:45']
		@event = Event.new
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@user = select_user
		@centers = Center.where(client_id: @user.client_id)
		@users = User.where(["client_id = ? and job_position = ?", @user.client_id, "Personal Médico"]) + Admin.where(["client_id = ?", @user.client_id])
	end

	def day_filter
		@user = select_user
		@events = Event.where(client_id: @user.client_id, date: params[:date], center_name: params[:center_name], doctor_name: params[:doctors].select{|key, hash| hash == "true" }.keys).order('start_time')
		respond_to do |format|
			format.json { render json: @events }
		end	
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
		@patient = @patients.find_by(["name LIKE ? and surname LIKE ?", params[:event][:patient_name], params[:event][:patient_surname]])
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
		@event.patient_age = (Date.today - params[:event][:patient_birthday].to_date).fdiv(365).to_i
		@event.patient_insurance = @patient.insurance
		@event.patient_history = @patient.history
		@event.client_id = @user.client_id
		if @event.save
			@user.events << @event
			@patient.events << @event
			redirect_to events_activity_panel_path(date: params[:event][:date])
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

@start_time_array = ['00:00', '00:15', '00:30', '00:45', '01:00', '01:15', '01:30', '01:45', '02:00', '02:15', '02:30', '02:45', '03:00', '03:15', '03:30', '03:45', '04:00', '04:15', '04:30', '04:45', '05:00', '05:15', '05:30', '05:45', '06:00', '06:15', '06:30', '06:45', '07:00', '07:15', '07:30', '07:45', '08:00', '08:15', '08:30', '08:45', '09:00', '09:15', '09:30', '09:45', '10:00', '10:15', '10:30', '10:45', '11:00', '11:15', '11:30', '11:45', '12:00', '12:15', '12:30', '12:45', '13:00', '13:15', '13:30', '13:45', '14:00', '14:15', '14:30', '14:45', '15:00', '15:15', '15:30', '15:45', '16:00', '16:15', '16:30', '16:45', '17:00', '17:15', '17:30', '17:45', '18:00', '18:15', '18:30', '18:45', '19:00', '19:15', '19:30', '19:45', '20:00', '20:15', '20:30', '20:45', '21:00', '21:15', '21:30', '21:45', '22:00', '22:15', '22:30', '22:45', '23:00', '23:15', '23:30', '23:45']


