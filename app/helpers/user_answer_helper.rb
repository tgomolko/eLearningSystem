module UserAnswerHelper
  def answered?(question)
    current_user.user_answers.pluck(:question_id).include?(question.id)
  end

  def all_questions_answered?(page)
    current_user.user_answers.where(question_id: page.questions.pluck(:id)).size == page.questions.size
  end
end
