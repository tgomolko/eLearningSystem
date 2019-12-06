class AddOrganizationIdToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :organization_id, :integer
  end
end
