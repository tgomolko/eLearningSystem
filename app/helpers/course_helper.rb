module CourseHelper
  def course_started?(course)
    current_user.following?(course)
  end

  def percent_of_progess(course, user)
    course_pages_ids = course.pages.pluck(:id)
    return 100 if course_pages_ids.empty?
    completed_pages_size = current_user.user_pages.where(page_id: course_pages_ids).size
    ((completed_pages_size.to_f / course.pages.size) * 100).round
  end

  def user_in_org?(user)
    user.organization_id
  end

  def course_completed?(course)
    current_user.user_courses.where(course_id: course.id).any?
  end
end
