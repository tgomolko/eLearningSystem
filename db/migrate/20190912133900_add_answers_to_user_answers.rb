class AddAnswersToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :answers, :hstore
  end
end
