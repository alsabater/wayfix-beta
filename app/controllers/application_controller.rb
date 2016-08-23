class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  devise_group :user_or_admin, contains: %i(admin user)

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in)        << [:name, :surname_1, :surname_2, :birthday, :country, :dni_passport, :phone_number_1, :phone_number_2, :job_position]
    devise_parameter_sanitizer.for(:sign_up)        << [:name, :surname_1, :surname_2, :birthday, :country, :dni_passport, :phone_number_1, :phone_number_2, :job_position]
    devise_parameter_sanitizer.for(:account_update) << [:name, :surname_1, :surname_2, :birthday, :country, :dni_passport, :phone_number_1, :phone_number_2, :job_position]
  end 

  def select_user 
    if current_user == nil
      user = current_admin
    else
      user = current_user
    end
    return user
  end

  protected

  def layout_by_resource
    if devise_controller?
      "before_wayfix"
    else
      "application"
    end
  end

end
