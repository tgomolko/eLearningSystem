module UserCourseHelper
  def certificate_url(path)
    path.split('/')[6..9].join('/').insert(0,"/")
  end

  def answer(question)
    answer = current_user.user_answers.find_by(question: question)
    if answer.answer
      answer.answer
    else
      answer.answers.select { |k,v| v == "true"}.keys.join(", ")
    end
  end
end
