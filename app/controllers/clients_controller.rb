class ClientsController < ApplicationController
before_action :must_be_admin

  def must_be_admin
  	if current_user.is_admin? == true
  	end
  end

  def new
  	flash[:success] = "Bienvenido a Wayfix. Es el momento de añadir la información de tu empresa"
	  @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      current_user.client_id = @client.id
      current_user.save
      @client.user_id = current_user.id
      redirect_to new_center_path
    else
      flash[:alert] = "No se ha podido registrar la empresa. Póngase en contacto con Wayfix"
    end
  end

  private
  def client_params
  	params.require(:client).permit!
  end
end