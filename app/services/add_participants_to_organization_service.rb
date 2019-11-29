class AddParticipantsToOrganizationService
  attr_reader :organization, :user

  def initialize(organization, user)
    @organization = organization
    @user = user
  end

  def call
    PotentialOrganizationParticipant.where(invited: false).each do |participant|
      if User.where(participant_org_id: nil).pluck(:email).include?(participant.email)
        add_participant_to_organization(participant)
      else
        SendOrganizationParticipantInvitationJob.new.perform(participant.email, user, organization)
      end
      participant.update(invited: true)
    end
  end

  private

  def add_participant_to_organization(participant)
    User.find_by(email: participant.email).update(participant_org_id: organization.id)
  end
end
