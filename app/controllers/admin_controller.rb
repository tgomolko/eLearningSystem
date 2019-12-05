class AdminController < ApplicationController
  before_action :authenticate_user!, :ensure_access_to_admin_dashboard!

  def pending_org
    @pending_org = Organization.pending
  end

  def organizations
    @organizations = Organization.all
  end

  private

  def ensure_access_to_admin_dashboard!
    redirect_to root_path, alert: t(:access_admin_disable) unless current_user.admin?
  end
end
