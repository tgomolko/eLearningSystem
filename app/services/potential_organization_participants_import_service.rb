class PotentialOrganizationParticipantsImportService
  attr_reader :organization, :user, :file

  def initialize(organization, user, file)
    @organization = organization
    @user = user
    @file = file
  end

  def call
    ParticipantsImportService.new(file).call
    AddParticipantsToOrganizationJob.new.perform(organization, user)
  end
end
