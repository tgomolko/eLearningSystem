module UserAnswerHelper
  def answered?(question)
    current_user.user_answers.pluck(:question_id).include?(question.id)
  end

  def all_question_answered?(page)
    page_questions = page.questions
    user_answers_count = current_user.user_answers.where(question_id: page_questions.pluck(:id)).size
    user_answers_count == page_questions.size
  end
end
