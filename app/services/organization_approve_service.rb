class OrganizationApproveService
  
  attr_reader :organization
  
  def initialize(organization)
    @organization = organization
  end

  def approve_organization
    if @organization.approved? 
      return false
    else
      @organization.approve!
      change_user_role
      return true 
    end
  end

  def reject_organization
    if @organization.rejected? 
      return false
    else
      @organization.reject!
      return true 
    end
  end

  private 

  def change_user_role
    user_id = @organization.user_id
    @user = User.find(user_id)
    @user.update_attributes(role: "org_admin") if @user.role == "user"
  end
end