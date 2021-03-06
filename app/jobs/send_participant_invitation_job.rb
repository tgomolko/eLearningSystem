class SendParticipantInvitationJob < ApplicationJob
  queue_as :mailers

  def perform(email, user_id, orgaization_id)
    user = User.find_by(id: user_id)
    organization = Organization.find_by(id: orgaization_id)
    UserMailer.invite_participant(email, user, organization).deliver_later
    PotentialOrganizationParticipant.find_by(email: email).update(invited: true)
  end
end
