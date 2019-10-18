class ManagerDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_access_manager_dashboard!

  def dashboard

  end

  private

  def ensure_access_manager_dashboard!
    unless current_user.role == "org_admin"
      redirect_to root_path, alert: t(:access__manager_disable)
    end
  end
end
