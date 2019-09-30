module UserAnswerHelper
  def answered?(question)
    answered_questions_ids = current_user.user_answers.pluck(:question_id)
    answered_questions_ids.include?(question.id)
  end
end
