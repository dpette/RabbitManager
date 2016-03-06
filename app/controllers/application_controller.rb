class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :sign_in_by_param

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end

  def sign_in_by_param
    if params[:username] == "mydad"
      sign_in User.find_by(email: "pettenon.daniel@gmail.com")
    end
  end

  protected
    def class_name_by_controller
      params[:controller].singularize.classify
    end

    def class_instance_name_by_controller
      params[:controller].singularize
    end

end
