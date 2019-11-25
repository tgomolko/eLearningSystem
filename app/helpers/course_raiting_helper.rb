module CourseRaitingHelper
  def user_rated_course?(course, user)
    course.course_raitings.where(user_id: user.id).empty?
  end

  def course_has_any_rate?(course)
    course.course_raitings.any?
  end

  def course_raiting(course)
    course.course_raitings.average(:rate).to_i
  end
end
