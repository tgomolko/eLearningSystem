class OrganizationApproveService

  def initialize(organization)
    @organization = organization
  end

  def approve_organization
    unless @organization.approved?
      @organization.approve!
      change_user_role
    end
  end

  def reject_organization            
    @organization.reject! unless @organization.rejected?
  end

  private 

  def change_user_role
    @user = User.find(@organization.user_id)
    @user.update_attributes(role: "org_admin") if @user.user?
  end
end
