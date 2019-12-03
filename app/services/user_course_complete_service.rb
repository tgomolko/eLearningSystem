class UserCourseCompleteService
  attr_reader :user, :user_course, :course, :result_counter

  def initialize(course, user, user_course, result_counter)
    @course = course
    @user = user
    @user_course = user_course
    @result_counter = result_counter
  end

  def complete
    user.unfollow(@course)
    set_user_course_params
    PdfCertificateGenerator.new(course, user, user_course, PdfFormFiller.new(user, course)).call if user_course.result >= 90
    user_course
  end

  private

  def set_user_course_params
    user_course.answered_correctly = result_counter.count_correct_answered_questions
    user_course.result = result_counter.result
  end
end
