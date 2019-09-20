module ApplicationHelper
 
  def answered?(question)
    answered_questions_ids = current_user.user_answers.pluck(:question_id)
    answered_questions_ids.include?(question.id)
  end

  def all_user_pages_completed?
    course_pages_ids = @course.pages.pluck(:id)
    return false if course_pages_ids.empty?
    current_user_pages_ids = current_user.user_pages.where(page_id: course_pages_ids)
    course_pages_ids.size == current_user_pages_ids.size
  end

  def course_started?(course)
    current_user.following?(course)
  end

  def check_on_completed(current_user)
    current_user.user_courses.pluck(:course_id).include?(@course.id)
  end

  def user_rated_course?(course, user)
    course.course_raiting.where(user_id: user.id).empty?
  end

  def course_has_any_rate?(course)
    course.course_raiting.any?
  end

  def course_raiting(course)
    if @course.course_raiting.any?
      (@course.course_raiting.pluck(:rate).reduce(:+) / @course.course_raiting.pluck(:rate).size.to_f).to_i
    else
      return 0
    end
  end
end
