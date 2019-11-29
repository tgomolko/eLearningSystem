class PotentialOrganizationParticipantsController < ApplicationController
  before_action :authenticate_user!, :set_organization, :validate_file_params

  def import
    if params[:file].content_type == "text/csv"
      PotentialOrganizationParticipantImportService.new(params[:file]).call
      AddParticipantsToOrganizationJob.new.perform(@organization, current_user)
      redirect_to manager_dashboard_path, notice: t(:invitations_sending_in_progress)
    else
      redirect_to manager_dashboard_path, alert: t(:file_is_not_csv)
    end
  end

  private

  def validate_file_params
    redirect_to manager_dashboard_path, alert: t(:file_no_chosen) unless params[:file]
  end

  def set_organization
    @organization = Organization.find(current_user.organization_id)
  end
end
