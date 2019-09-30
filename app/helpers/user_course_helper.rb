module UserCourseHelper

  def certificate_url(path)
    path.split('/')[6..9].join('/').insert(0,"/")
  end
  
  def check_on_completed(current_user)
    current_user.user_courses.pluck(:course_id).include?(@course.id)
  end
end
