class SettingsController < ApplicationController
	before_action :authenticate_admin!, only: :invite_user
  protect_from_forgery with: :null_session

  def select_user	
	if current_user == nil
	  user = current_admin
	else
	  user = current_user
	end
	return user
  end

  def index
  	@client = Client.find(select_user.client_id)
  	@centers = Center.where(client_id: @client.id)
  	@users = User.where(client_id: select_user.client_id)
  end

  def invite_user
  	@user = User.new
  	@centers = Center.where(client_id: current_admin.client_id)
  end

  def add_personnel_to_center
    @users = User.where(id: params["users"])
    @center = Center.find(params["center_id"])
    @center.users << @users
    redirect_to settings_path
  end

end