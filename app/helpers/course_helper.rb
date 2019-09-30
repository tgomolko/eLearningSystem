module CourseHelper

  def course_started?(course)
    current_user.following?(course)
  end
  
  def percent_of_progess(course, user)
    course_pages_ids = course.pages.pluck(:id)
    completed_pages = current_user.user_pages.where(page_id: course_pages_ids).size
    (completed_pages.to_f / course.pages.size.to_f) * 100
  end
end
