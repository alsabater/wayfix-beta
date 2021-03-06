class CentersController < ApplicationController
  before_action :authenticate_user!
  before_action :must_be_admin
  layout "before_wayfix"
  def new
  	flash.now[:success] = "Añade ahora una clínica perteneciente a la sociedad registrada. Más adelante podrás añadir personal a la clínica o crear más clínicas."
  	@center = Center.new
  end

  def create
  	@center = Center.new(center_params)
    @center.client_id = current_user.client_id
    if @center.save
  	  redirect_to settings_path
  	else
      flash.now[:alert] = "No se ha podido crear la clínica. Póngase en contacto con Wayfix"
    end
  end

  private
  def center_params
  	params.require(:center).permit!
  end
end