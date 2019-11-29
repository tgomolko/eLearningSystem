class AddParticipantsToOrganizationJob < ApplicationJob
  queue_as :default

  def perform(organization, user)
    AddParticipantsToOrganizationService.new(organization, user).call
  end
end
