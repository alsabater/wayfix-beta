class RegistrationsController < Devise::RegistrationsController
	before_action :authenticate_admin!
	skip_before_action :require_no_authentication
	before_filter :configure_permitted_parameters, :only => [:create]


	def create
		@user = User.new(user_params)
		@user.client_id = current_admin.client_id
		@centers = Center.where(id: params["centers"])
		@user.centers << @centers
		if @user.save
			redirect_to settings_path
		end
	end

	private

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up)        << [:email, :password, :password_confirmation, :name, :surname_1, :surname_2, :birthday, :country, :dni_passport, :phone_number_1, :phone_number_2, :job_position]
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname_1, :surname_2, :birthday, :country, :dni_passport, :phone_number_1, :phone_number_2, :job_position, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip )
	end
end