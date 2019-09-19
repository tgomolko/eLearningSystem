module ApplicationHelper
 
  def answered?(question)
    answered_questions_ids = current_user.user_answers.pluck(:question_id)
    answered_questions_ids.include?(question.id)
  end

  def all_user_pages_completed?
    course_pages_ids = @course.pages.pluck(:id)
    current_user_pages_ids = current_user.user_pages.where(page_id: course_pages_ids)
    course_pages_ids.size == current_user_pages_ids.size
  end

  def course_started?(course)
    current_user.following?(course)
  end

  def check_on_completed(current_user)
    current_user.user_courses.pluck(:course_id).include?(@course.id)
  end
end
