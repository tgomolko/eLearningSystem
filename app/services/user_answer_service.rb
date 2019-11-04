class UserAnswerService
  attr_reader :user_answer, :params

  def initialize(user_answer, params)
    @user_answer = user_answer
    @params = params
  end

  def set_user_answers_values
    user_answer.answers = user_question_answers_hash
  end

  private

  def user_question_answers_hash
    if params[:user] && params[:answer_keys]
      answers = params[:user][:answers]
      answers_keys = @params[:answer_keys]
      Hash[answers_keys.zip answers]
    else
      Hash.new
    end
  end
end
