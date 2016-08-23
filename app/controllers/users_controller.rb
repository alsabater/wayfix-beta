class UsersController < ApplicationController
	before_action :authenticate_admin!, only: [:create, :destroy]
	before_filter :authenticate_user_or_admin!, only: [:edit, :update]

	# before_action :user_owns_account, only: [:edit]
	layout "before_wayfix", only: [:edit]


	def create
		@user = User.new(user_params)
		@user.client_id = current_admin.client_id
		@centers = Center.where(id: params["centers"])
		@user.centers << @centers
		if @user.save
			redirect_to settings_path
		end
	end

	def edit
		@user = User.find(params[:id])
		user_owns_account
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			sign_in @user, :bypass => true
			redirect_to dashboard_path
		else 
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy!
		if @user.destroy
			redirect_to settings_path    
		else
			flash.now[:danger] = "No se ha podido eliminar a " + @user.name + @user.surname_1
			redirect_to settings_path
		end
	end

	def user_owns_account
		if @user != current_user
			redirect_to new_user_session_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname_1, :surname_2, :birthday, :country, :dni_passport, :phone_number_1, :phone_number_2, :job_position, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip )
	end
end