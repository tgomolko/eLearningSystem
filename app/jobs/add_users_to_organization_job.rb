class AddUsersToOrganizationJob < ApplicationJob
  queue_as :default

  def perform(organization_id)
    users_emails = User.pluck(:email)
    Email.all.each do |email|
      if users_emails.include?(email.email)
        email.update_attributes(invited: true)
        user = User.find_by(email: email.email)
        user.update_attributes(participant_org_id: organization_id ) if user.participant_org_id.nil?
      end
    end
  end
end
