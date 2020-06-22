class AssignParticipantsToOrganizationJob < ApplicationJob
  queue_as :default

  def perform(organization_id, current_user_id)

    organization = Organization.find(organization_id)
    current_user = User.find(current_user_id)
    AssignParticipants.new(organization, current_user).call
  end
end
