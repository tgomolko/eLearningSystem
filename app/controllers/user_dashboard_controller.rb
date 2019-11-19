class UserDashboardController < ApplicationController
  before_action :authenticate_user!, :dashboard_service
  helper_method :sort_column, :sort_direction

  def dashboard
    @uncompleted_courses, @completed_courses, @highest_rate_courses, @favorite_courses, @org_courses, @not_org_courses = @user_dashboard_service.build_dashboard_data
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

  def org_courses
    @org_courses = @user_dashboard_service.org_courses_search
  end

  def not_org_courses
    @not_org_courses = @user_dashboard_service.not_org_courses_search
  end

  def user_courses
    @user_courses = @user_dashboard_service.user_courses_search
  end

  def user_certificates
    @user_certificates = @user_dashboard_service.user_certificates_search
  end

  private

  def dashboard_service
    @user_dashboard_service = UserDashboardService.new(current_user, params)
  end

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
