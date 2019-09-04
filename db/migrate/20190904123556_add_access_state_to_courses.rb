class AddAccessStateToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :access_state, :string
  end
end
