class EmailController < ApplicationController
  before_action :authenticate_user!, :set_organization, :validate_file_params

  def import
    if params[:file].content_type == "text/csv" && Email.import(params[:file])
      AddUsersToOrganizationJob.new.perform(current_user.organization_id)
      UserEmailInvitationService.new(current_user, @organization).send_email_invites
      redirect_to manager_dashboard_path, notice: t(:emails_imported)
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
