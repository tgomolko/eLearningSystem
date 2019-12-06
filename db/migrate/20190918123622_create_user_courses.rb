class CreateUserCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_courses do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.boolean :completed, default: false
      t.float :result
      t.integer :answered_correctly, default: 0
      t.timestamps
    end
  end
end
