class OrganizationApproveService
  
  attr_reader :organization
  
  def initialize(organization)
    @organization = organization
  end

  def approve_organization
    if @organization.approved?
    else
      @organization.approve!
      change_user_role
    end
  end

  def reject_organization
    if @organization.rejected?     
    else
      @organization.reject!
    end
  end

  private 

  def change_user_role
    user_id = @organization.user_id
    @user = User.find(user_id)
    @user.role == "user" ? @user.update_attributes(role: "org_admin") : true
  end
end
