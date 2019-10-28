class ImportEmailService
  def initialize(organization_id)
    @organization_id = organization_id
  end

  def add_users_to_organization
    users_emails = User.pluck(:email)
    Email.pluck(:email).each do |email|
      if users_emails.include?(email)
        user = User.find_by(email: email)
        user.update_attributes(participant_org_id: @organization_id ) if user.participant_org_id.nil?
      end
    end
  end
end
