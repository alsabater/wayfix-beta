class ClientsController < ApplicationController
before_action :authenticate_admin!
layout "before_wayfix"

  def new
  	flash.now[:success] = "Bienvenido a Wayfix. Es el momento de añadir la información de tu empresa"
	  @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_admin.id
    if @client.save
      current_admin.client_id = @client.id
      current_admin.save
      redirect_to new_center_path
    else
      flash.now[:alert] = "No se ha podido registrar la empresa. Póngase en contacto con Wayfix"
    end
  end

  private
  def client_params
  	params.require(:client).permit!
  end
end