class SettingsController < ApplicationController
  def index
  	@client = Client.where(user_id: current_user.id).first
  	@center = Center.where(client_id: @client.id)
  end
end