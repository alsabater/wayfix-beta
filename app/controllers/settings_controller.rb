class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@client = Client.find(current_user.client_id)
  	@center = Center.where(client_id: @client.id)
  	@users = User.where(invited_by_id: current_user.id)
  end
end