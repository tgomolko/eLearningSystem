module QuestionHelper
  def question_answer(question)
    if question.textbox?
      question.answer
    else
      question.answers.select { |possible_answer, option| option == "true" }.keys.join(", ")
    end
  end

  def submit_question_tag(question)
    if question.answered?(current_user)
      submit_tag 'Question answered!', class: 'button is-small is-info is-dis'
    else
      submit_tag 'Answer on question', class: 'button is-small is-primary'
    end
  end
end
