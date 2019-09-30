class CourseRaitingService

  def initialize(course)
    @course = course
  end

  def calculate_course_raiting
   #binding.pry
    if @course.course_raiting.any?
      (@course.course_raiting.pluck(:rate).reduce(:+) / @course.course_raiting.pluck(:rate).size.to_f).to_i
  #  binding.pry
    else
      return 0
    end
  end
end
