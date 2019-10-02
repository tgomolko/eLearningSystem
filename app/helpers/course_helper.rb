module CourseHelper

  def course_started?(course)
    current_user.following?(course) if user_signed_in?
  end
  
  def percent_of_progess(course, user)
    course_pages_ids = course.pages.pluck(:id)
    return 100 if course_pages_ids.empty?
    completed_pages = current_user.user_pages.where(page_id: course_pages_ids).size
    (completed_pages.to_f / course.pages.size) * 100
  end
end
