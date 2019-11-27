class ManagerDashboardController < ApplicationController
  before_action :authenticate_user!, :ensure_access_to_manager_dashboard!, :set_manager_dashboard_service
  helper_method :sort_column, :sort_direction, :sort_user_column, :sort_direction

  def dashboard ; end

  def organization_courses
    @organization_courses = @manager_dashboard_service.organization_courses
  end

  def organization_users
    @organization_users = @manager_dashboard_service.organization_users
  end

  private

  def set_manager_dashboard_service
    @manager_dashboard_service = ManagerDashboardService.new(current_user, params)
  end

  def ensure_access_to_manager_dashboard!
    unless current_user.org_admin?
      redirect_to root_path, alert: t(:access_manager_disable)
    end
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
