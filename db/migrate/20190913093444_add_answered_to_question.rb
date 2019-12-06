class AddAnsweredToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :answered, :boolean, default: false
  end
end
