class CreateCourseRaitings < ActiveRecord::Migration[5.2]
  def change
    create_table :course_raitings do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :rate, default: 0

      t.timestamps
    end
  end
end
