class AddDefaultValueToResultAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :user_courses, :result, :float, default: false
  end
end
