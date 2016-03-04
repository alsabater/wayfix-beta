class CentersUsersController < ApplicationController
	#IN ORDER TO BE ABLE TO DESTROY RELATIONS BETWEEN USERS AND CENTERS
	def destroy
		@user = User.find(params[:user_id])
		@center = Center.find(params[:center_id])
		@center.users.delete(@user)
		redirect_to settings_path
	end
end
