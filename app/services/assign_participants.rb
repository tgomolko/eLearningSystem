class AssignParticipants
  attr_reader :organization, :user

  def initialize(organization, user)
    @organization = organization
    @user = user
  end

  def call
    not_invited_participants.each do |participant|
      if User.find_by(email: participant.email)
        add_participant_to_organization(participant)
      else
        SendParticipantInvitationJob.new.perform(participant.email, user.id, organization.id)
      end
    end
  end

  private

  def add_participant_to_organization(participant)
    ActiveRecord::Base.transaction do
      User.find_by(email: participant.email).update(participant_org_id: organization.id)
      participant.update(invited: true)
    end
  end

  def not_invited_participants
    PotentialOrganizationParticipant.not_invited
  end
end
