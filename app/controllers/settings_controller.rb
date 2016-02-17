class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@client = Client.find(current_user.client_id)
  	@center = Center.where(client_id: @client.id)
  end
end