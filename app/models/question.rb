class Question < ApplicationRecord
  belongs_to :page
  has_many :user_answers, dependent: :destroy

  enum question_type: [:textbox, :radio, :checkbox]

  def answered?(current_user)
    user_answers.where(user_id: current_user.id).any?
  end
end
