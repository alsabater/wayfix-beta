class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@client = Client.find_by(current_user.client_id)
  	@center = Center.where(client_id: @client.id)
  	@all_users = User.all
  end
end