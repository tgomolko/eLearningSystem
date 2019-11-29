class UserCourseCompleteService
  attr_reader :user, :user_course, :course

  def initialize(course, user, user_course)
    @course = course
    @user = user
    @user_course = user_course
    @true_user_answers = 0
  end

  def call
    answered_right = true_answered_questions_count
    user.unfollow(@course)
    if answered_right
      user_course.result = result
      user_course.answered_correctly = answered_right
      generate_certificate(user, course)
    else
      user_course.result = 0
    end
    user_course
  end

  private

  def true_answered_questions_count
    return if course_questions.empty?
    true_user_answers_count
    true_user_answers_text_question_count
    @true_user_answers
  end

  def result
    @result = ((@true_user_answers.to_f / course_questions.size) * 100).round(2)
  end

  def course_questions
    course.pages.each_with_object([]) do |page, course_questions|
      course_questions << page.questions
    end.flatten
  end

  def course_text_questions_answers
    textbox_questions = course_questions.select { |q| q.question_type == "textbox"}
    Hash[textbox_questions.pluck(:id).zip textbox_questions.pluck(:answer)]
  end

  def course_questions_answers
    questions = course_questions.reject { |q| q.question_type == "textbox" }
    Hash[questions.pluck(:id).zip questions.pluck(:answers)]
  end

  def user_answers
    @user_answers ||= user.user_answers.where(course_id: course.id)
  end

  def text_questions_user_answers
    text_user_answers = user_answers.select { |a| a.answer }
    Hash[text_user_answers.pluck(:question_id).zip text_user_answers.pluck(:answer)]
  end

  def course_question_user_answers
    question_answers = user_answers.select { |a| a.answers.any? }
    Hash[question_answers.pluck(:question_id).zip question_answers.pluck(:answers)]
  end

  def true_user_answers_text_question_count
    course_text_questions_answers.values.each do |answer|
      text_questions_user_answers.values.each do |u_answer|
        if answer == u_answer
          @true_user_answers += 1
        end
      end
    end
  end

  def true_user_answers_count
    course_questions_answers.values.each do |answer|
      course_question_user_answers.values.each do |u_answer|
        if answer == u_answer
          @true_user_answers += 1
        end
      end
    end
  end

  def generate_certificate(user, course)
    return if @result <= 90
    user_course.certificate_path = TestPdfForm.new(user, course).export()
  end
end
