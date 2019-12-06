class RenameTypeColumnInQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :type, :question_type
  end
end
