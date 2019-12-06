class ManagerDashboardController < ApplicationController
  before_action :authenticate_user!, :ensure_access_to_manager_dashboard!, :initialize_manager_dashboard_service
  helper_method :sort_column, :sort_direction, :sort_user_column, :sort_direction

  def organization_courses
    @organization_courses = @manager_dashboard_service.organization_courses_search
  end

  def organization_users
    @organization_users = @manager_dashboard_service.organization_users_search
  end

  private

  def initialize_manager_dashboard_service
    @manager_dashboard_service = ManagerDashboardService.new(current_user, params)
  end

  def ensure_access_to_manager_dashboard!
    redirect_to root_path, alert: t(:access_manager_disable) unless current_user.org_admin?
  end

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_user_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
