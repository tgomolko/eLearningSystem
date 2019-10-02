class ApplicationController < ActionController::Base
   include Pundit
   protect_from_forgery

  def after_sign_in_path_for(resource)
    user_dashboard_dashboard_path
  end
end
