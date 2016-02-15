class CentersController < ApplicationController
  def new
  	flash[:success] = "Añade ahora una clínica perteneciente a la sociedad registrada. Más adelante podrás añadir personal a la clínica o crear más clínicas."
  	@center = Center.new
  end

  def create
  	@center = Center.new(center_params)
    if @center.save
  	  @center.client_id = current_user.client_id
  	  redirect_to settings_path
  	else
      flash[:alert] = "No se ha podido crear la clínica. Póngase en contacto con Wayfix"
    end
  end

  private
  def center_params
  	params.require(:center).permit!
  end
end