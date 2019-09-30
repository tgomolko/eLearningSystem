module CourseRaitingHelper

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
