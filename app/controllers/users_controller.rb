class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_get_admin_dashboard!, only: :dashboard

  def dashboard
  end

  private

  def ensure_get_admin_dashboard!
    if current_user.role != "admin"
      redirect_to root_path, alert: "You don't belong there!"
    end
  end
end