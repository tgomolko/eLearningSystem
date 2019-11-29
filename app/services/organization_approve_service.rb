class OrganizationApproveService
  attr_reader :organization, :user

  def initialize(organization)
    @organization = organization
    @user = User.find(@organization.user_id)
  end

  def approve_organization
    unless organization.approved?
      organization.approve!
      user.update(organization_id: organization.id, participant_org_id: organization.id)
      user.update(role: "org_admin") if user.user?
    end
  end

  def reject_organization
    organization.reject! unless organization.rejected?
  end
end
