class ImportEmailService
  def initialize(organization_id)
    @organization_id = organization_id
  end

  def add_users_to_organization
    AddUsersToOrganizationJob.new.perform(@organization_id)
  end
end
