class RenameEmailsToPotentialOrganizationParticipants < ActiveRecord::Migration[5.2]
  def change
    rename_table :emails, :potential_organization_participants
  end
end
