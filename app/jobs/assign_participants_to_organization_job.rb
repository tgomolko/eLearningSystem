class AssignParticipantsToOrganizationJob < ApplicationJob
  queue_as :default

  def perform(organization_id, currrent_user_id)
    organization = Organization.find(organization_id)
    currrent_user = User.find(currrent_user_id)
    AssignParticipants.new(organization, currrent_user).call
  end
end
