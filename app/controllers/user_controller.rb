class UserController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    user_dashboard_service = UserDashboardService.new(current_user)

    @uncompleted_courses = user_dashboard_service.get_uncompleted_courses
    @completed_courses = user_dashboard_service.get_completed_courses
    @highest_rate_courses = user_dashboard_service.get_highest_rate_courses
    @favorite_courses = user_dashboard_service.get_favorite_courses
  end
end
