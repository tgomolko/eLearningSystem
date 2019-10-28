class ManagerDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_access_manager_dashboard!
  helper_method :sort_column, :sort_direction

  def dashboard
    @organization_courses = ManagerDashboardService.new(current_user, params).organization_courses_search
  end

  private

  def ensure_access_manager_dashboard!
    unless current_user.org_admin?
      redirect_to root_path, alert: t(:access_manager_disable)
    end
  end

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
