class CancelCourseService
  attr_reader :course, :user

  def initialize(course, user)
    @course = course
    @user = user
  end

  def call
    if user.user_courses.where(course_id: course.id).empty?
      user.unfollow(@course)
      delete_user_answers_and_pages
    end
  end

  def delete_user_answers_and_pages
    user.user_pages.where(page_id: course.pages.ids).destroy_all
    user.user_answers.where(course_id: course.id).destroy_all
  end
end
