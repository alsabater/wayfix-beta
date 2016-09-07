class HomeController < ApplicationController
  before_action :authenticate_user_or_admin!

  def index
  	@user = select_user
  	if admin_signed_in? && @user.client_id == nil
      redirect_to new_client_path
    elsif @user.sign_in_count == 1
   	  redirect_to edit_user_path(@user.id)
    else
      redirect_to settings_path
    end
  end
end

