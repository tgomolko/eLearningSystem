class WelcomeController < ApplicationController
  def index
    redirect_to user_dashboard_path and return if user_signed_in?
    @courses = Course.ready.last(5)
  end
end
