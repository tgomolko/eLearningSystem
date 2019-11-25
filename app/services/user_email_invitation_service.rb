class UserEmailInvitationService
  attr_reader :user, :organization

  def initialize(user, organization)
    @user = user
    @organization = organization
  end

  def send_email_invites
    Email.where(invited: false).each do |email|
      SendNewUserInvitationJob.new.perform(email.email, user, organization)
      email.update_attributes(invited: true)
    end
  end
end
