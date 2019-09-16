class UserAnswerService

  def initialize(question)
    @question = question
  end

  def set_answered
    @question.update_attributes(answered: true) unless @question.answered?
  end
end
