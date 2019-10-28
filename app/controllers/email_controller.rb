class EmailController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_files_params

  def import
    if params[:file].content_type == "text/csv"
      Email.import(params[:file])
      redirect_to manager_dashboard_path, notice: t(:emails_imported)
    else
      redirect_to manager_dashboard_path, alert: t(:file_is_not_csv)
    end
  end

  def validate_files_params
    redirect_to manager_dashboard_path, alert: t(:file_no_chosen) unless params[:file]
  end
end
