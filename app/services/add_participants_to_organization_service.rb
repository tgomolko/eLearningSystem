class AddParticipantsToOrganizationService
  attr_reader :organization, :user

  def initialize(organization, user)
    @organization = organization
    @user = user
  end

  def call
    users_emails = User.where(participant_org_id: nil).pluck(:email)
    PotentialOrganizationParticipant.where(invited: false).each do |participant|
      if users_emails.include?(participant.email)
        add_participant_to_organization(participant, organization.id)
      else
        SendOrganizationParticipantInvitationJob.new.perform(participant.email, user, organization)
        participant.update(invited: true)
      end
    end
  end

  private

  def add_participant_to_organization(participant, organization_id)
    participant.update(invited: true)
    user = User.find_by(email: participant.email)
    user.update(participant_org_id: organization_id)
  end
end
