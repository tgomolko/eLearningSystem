class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :aasm_state
      t.references :user, foreign_key: true
      t.text :requirements
      
      t.timestamps
    end
  end
end
