class UserCourseCompleteService
  attr_reader :user, :user_course, :course

  def initialize(course, user, user_course)
    @course = course
    @user = user
    @user_course = user_course
    @true_user_answers = 0
  end

  def create_user_course
    answered_right = true_answered_questions_count
    if answered_right
      user_course.result = result
      user_course.answered_correctly = answered_right
      user.unfollow(@course)
      generate_certificate(user, course)
    else
      user_course.result = 0
    end
    user_course
  end

  private

  def true_answered_questions_count
    return if get_all_questions_of_course.size == 0 #if page doesn't have any question
    count_true_answers_on_text_questions
    count_true_answers_on_another_questions
    @true_user_answers
  end

  def result
    @result = ((@true_user_answers.to_f / get_all_questions_of_course.size) * 100).round(2)
  end

  def get_all_questions_of_course
    all_course_questions = []
    course.pages.each do |page|
      all_course_questions << page.questions
    end
    all_course_questions.flatten
  end

  def create_hash_of_text_questions_ids_and_answers
    textbox_questions ||= get_all_questions_of_course.select { |q| q.question_type == "textbox"}
    Hash[textbox_questions.pluck(:id).zip textbox_questions.pluck(:answer)]
  end

  def create_hash_of_another_questions_ids_and_answers
    another_questions ||= get_all_questions_of_course.select { |q| q.question_type == ("checkbox" || "radio") }
    Hash[another_questions.pluck(:id).zip another_questions.pluck(:answers)]
  end

  def get_all_user_answers
    user_answers ||= user.user_answers.where(course_id: course.id)
  end

  def create_hash_of_user_answers_on_text_questions
    answers_on_text_questions ||= get_all_user_answers.select { |a| a.answer }
    Hash[answers_on_text_questions.pluck(:question_id).zip answers_on_text_questions.pluck(:answer)]
  end

  def create_hash_of_user_answers_on_another_questions
    answers_on_another_questions ||= get_all_user_answers.select { |a| a.answers.any? }
    Hash[answers_on_another_questions.pluck(:question_id).zip answers_on_another_questions.pluck(:answers)]
  end

  def count_true_answers_on_text_questions
    create_hash_of_text_questions_ids_and_answers.values.each do |answer|
      create_hash_of_user_answers_on_text_questions.values.each do |u_answer|
        if answer == u_answer
          @true_user_answers += 1
        end
      end
    end
    @true_user_answers
  end

  def count_true_answers_on_another_questions
     create_hash_of_another_questions_ids_and_answers.values.each do |answer|
      create_hash_of_user_answers_on_another_questions.values.each do |u_answer|
        if answer == u_answer
          @true_user_answers += 1
        end
      end
    end
    @true_user_answers
  end

  def generate_certificate(user, course)
    return if @result <= 90
    certificate_path = TestPdfForm.new(user, course).export()
    user_course.certificate_path = certificate_path
  end
end
