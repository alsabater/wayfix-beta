class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@user = current_user
	if @user.sign_in_count == 1 && @user.is_admin? == true
      redirect_to new_client_path
    end
  end
end
