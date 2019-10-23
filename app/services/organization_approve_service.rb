class OrganizationApproveService

  def initialize(organization)
    @organization = organization
    @user = User.find(@organization.user_id)
  end

  def approve_organization
    unless @organization.approved?
      @organization.approve!
      @user.update_attributes(organization_id: @organization.id)
      @user.update_attributes(role: "org_admin") if @user.user?
    end
  end

  def reject_organization
    @organization.reject! unless @organization.rejected?
  end
end
