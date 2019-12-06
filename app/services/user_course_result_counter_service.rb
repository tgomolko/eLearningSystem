class UserCourseResultCounterService
  attr_reader :course, :user, :corrent_answers_count

  def initialize(course, user)
    @course = course
    @user = user
    @correct_answers_count = 0
  end

  def result
    ((@correct_answers_count.to_f / course_questions.size) * 100).round(2)
  end

  def count_correct_answered_questions
    return if course_questions.empty?
    count_corrent_answers
    count_correct_text_questions_answers
    @correct_answers_count
  end

  private

  def course_questions
    course.pages.each_with_object([]) do |page, course_questions|
      course_questions << page.questions
    end.flatten
  end

  def course_text_questions_answers
    textbox_questions = course_questions.select { |q| q.textbox? }
    Hash[textbox_questions.pluck(:id).zip textbox_questions.pluck(:answer)]
  end

  def course_questions_answers
    questions = course_questions.reject { |q| q.textbox? }
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

  def count_correct_text_questions_answers
    @correct_answers_count += course_text_questions_answers.values.each_with_index.count do |answer, index|
      text_questions_user_answers.values[index] == answer
    end
  end

  def count_corrent_answers
    @correct_answers_count += course_questions_answers.values.each_with_index.count do |answer, index|
      course_question_user_answers.values[index] == answer
    end
  end
end
