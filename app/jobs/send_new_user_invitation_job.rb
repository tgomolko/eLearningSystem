class SendNewUserInvitationJob < ApplicationJob
  queue_as :mailers

  def perform(email, user, orgaization)
    @email = email.email
    @user = user
    @orgaization = orgaization
    UserMailer.invite_user_by_email(@email, @user, @orgaization).deliver_later
  end
end
