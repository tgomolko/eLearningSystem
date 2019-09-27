class AddCertificateUrlToUserCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :user_courses, :certificate_path, :string
  end
end
