class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_access_admin_dashboard!

  def dashboard ; end

  def pending_org
    @pending_org = Organization.where(aasm_state: "pending")
  end

  def organizations
    @organizations = Organization.all
  end

  private

  def ensure_access_admin_dashboard!
     unless current_user.admin?
      redirect_to root_path, alert: t(:access_admin_disable)
    end
  end
end
