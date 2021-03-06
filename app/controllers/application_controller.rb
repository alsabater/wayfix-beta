class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      "before_wayfix"
    else
      "application"
    end
  end

  def must_be_admin
    if current_user.is_admin? == true
    end
  end
end
