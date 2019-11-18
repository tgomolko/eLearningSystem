class FinishCourseService
  attr_reader :course, :user

  def initialize(course, user)
    @course = course
    @user = user
  end

  def remove_user_answers_and_pages
    user.user_pages.where(page_id: course.pages.ids).destroy_all
    user.user_answers.where(course_id: course.id).destroy_all
  end

  def course_completed?
    user.user_courses.where(course_id: course.id).empty?
  end
end
