class WelcomeController < ApplicationController
  layout "welcome"

  def index
    redirect_to user_dashboard_path and return if user_signed_in?
    @courses = Course.ready.first(5)
  end
end
