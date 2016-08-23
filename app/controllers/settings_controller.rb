class SettingsController < ApplicationController
	before_action :authenticate_admin!, only: [:invite_user, :add_personnel_to_center]
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def index
    @user = select_user
  	@client = Client.find(@user.client_id)
  	@centers = Center.where(client_id: @client.id)
  	@users = User.where(client_id: @user.client_id)
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