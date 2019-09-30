module UserCourseHelper
  
 def check_on_completed(current_user)
    current_user.user_courses.pluck(:course_id).include?(@course.id)
  end
end
