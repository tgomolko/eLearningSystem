class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :company_name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
