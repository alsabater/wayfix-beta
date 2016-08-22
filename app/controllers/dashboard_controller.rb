class DashboardController < ApplicationController
  before_action :authenticate_user_or_admin!

  def index
  	@user = current_user
  	# REDIRIGIR A SETTINGS DONDE PUEDA CAMBIAR DATOS PERSONALES
  end
end