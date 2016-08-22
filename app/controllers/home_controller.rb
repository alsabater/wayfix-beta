class HomeController < ApplicationController
  before_action :authenticate_user_or_admin!

  def index
    @admin = current_admin
  	if admin_signed_in? == true && @admin.client_id == nil
      redirect_to new_client_path
    else
      redirect_to settings_path
    end
  end
end

