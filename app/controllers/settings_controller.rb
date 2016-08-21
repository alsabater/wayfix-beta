class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@client = Client.find(current_user.client_id)
  	@center = Center.where(client_id: @client.id)
  	@users = User.where(client_id: current_user.client_id)
  end

  def invite_user
  	@user = User.new
  	@centers = Center.where(client_id: current_user.client_id)
  end
end