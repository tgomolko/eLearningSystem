class UserDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :service_dashboard
  helper_method :sort_column, :sort_direction

  def dashboard
    @uncompleted_courses = @user_dashboard_service.get_uncompleted_courses.last(5)
    @completed_courses = @user_dashboard_service.get_completed_courses.last(5)
    @highest_rate_courses = @user_dashboard_service.get_highest_rate_courses.last(5)
    @favorite_courses = @user_dashboard_service.get_favorite_courses.last(5)
  end

  def current_courses
    @current_courses = @user_dashboard_service.current_courses_search
  end

  def favorites
    @favorite_courses = @user_dashboard_service.favorites_courses_search
  end

  def last_completed
    @completed_courses = @user_dashboard_service.completed_courses_search
  end

  def recomendations
    @highest_rate_courses = @user_dashboard_service.recomendation_courses_search
  end

  private 

  def service_dashboard
    @user_dashboard_service = UserDashboardService.new(current_user, params) 
  end

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
