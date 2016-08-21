class HomeController < ApplicationController
  
  def index
  	if current_admin.client_id == nil && admin_signed_in?
      redirect_to new_client_path
    else
      redirect_to settings_path
    end
  end
end

