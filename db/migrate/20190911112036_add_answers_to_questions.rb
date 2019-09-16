class AddAnswersToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :answers, :hstore
  end
end
