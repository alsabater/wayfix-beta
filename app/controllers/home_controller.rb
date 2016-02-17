class HomeController < ApplicationController
  before_action :authenticate_user!

  def redirection_options
  	if @user.client_id == nil && @user.is_admin? == true
      redirect_to new_client_path
    elsif @user.is_admin? == true && @user.client_id != nil 
      redirect_to settings_path
    end
  end

  def index
  	@user = current_user
  	if @user.created_by_invite?
  	  @user.update_attributes(is_admin?: false)
  	  @user.client_id = Client.where(user_id: @user.invited_by_id).first.id
  	  @user.save
      redirect_to settings_path
    else 
      redirection_options
    end
  end
end

