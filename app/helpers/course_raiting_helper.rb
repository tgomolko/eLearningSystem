module CourseRaitingHelper
  def user_rated_course?(course, user)
    course.course_raiting.where(user_id: user.id).empty?
  end

  def course_has_any_rate?(course)
    course.course_raiting.any?
  end

  def course_raiting(course)
    course.course_raiting.average(:rate).to_i
  end
end
