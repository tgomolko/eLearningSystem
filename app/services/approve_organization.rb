class ApproveOrganization
  attr_reader :organization, :user

  def initialize(organization)
    @organization = organization
    @user = User.find(@organization.user_id)
  end

  def call
    return if organization.approved?

    organization.approve!
    user.update(organization_id: organization.id, participant_org_id: organization.id)
    user.org_admin! if user.user?
  end
end
