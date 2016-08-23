class DashboardController < ApplicationController
before_filter :authenticate_user_or_admin!

  def index
  	@user = select_user
  end
end