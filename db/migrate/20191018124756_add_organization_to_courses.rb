class AddOrganizationToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :organization, foreign_key: true
  end
end
