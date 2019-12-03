module QuestionHelper
  def question_answer(question)
    if question.textbox?
      question.answer
    else
      question.answers.select { |possible_answer, option| option == "true" }.keys.join(", ")
    end
  end
end
