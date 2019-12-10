module UserCourseHelper
  def certificate_url(path)
    path.split('/')[6..9].join('/').insert(0,"/")
  end

  def user_answer(question)
    answer = current_user.user_answers.find_by(question: question)
    if answer.answer
      answer.answer
    else
      answer.answers.select { |possible_answer, option| option == "true" }.keys.join(", ")
    end
  end

  def course_raiting_form(course)
    if current_user.rated_course?(course)
      content_tag(:div, "", class: "review-rating", "data-score" => course.avg_rate)
    else
      render partial: 'course_raitings/course_raiting_form'
    end
  end

  def user_certificate(user_course)
    return unless user_course.certificate_path
    link_to(certificate_url(user_course.certificate_path)) do
      content_tag(:span, content_tag(:i, "", class: "fa fa-file-pdf-o")).html_safe
    end
  end
end
