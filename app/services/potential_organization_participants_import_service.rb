class PotentialOrganizationParticipantsImportService
  attr_reader :organization, :current_user, :file

  def initialize(organization, current_user, file)
    @organization = organization
    @current_user = current_user
    @file = file
  end

  def import
    ParticipantsCSVImport.new(file).call
    AssignParticipantsToOrganizationJob.perform_later(organization.id, current_user.id)
  end
end
