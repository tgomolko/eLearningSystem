class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_get_admin_dashboard!, only: [:dashboard, :pending_org, :organizations]

  def dashboard
  end

  def pending_org
    @pending_org = Organization.where(aasm_state: "pending")
  end

  def organizations
    @organizations = Organization.all
  end

  private

  def ensure_get_admin_dashboard!
    if current_user.role != "admin"
      redirect_to root_path, alert: "You don't belong there!"
    end
  end
end