class UserAnswerService
  attr_reader :user_answer, :params

  def initialize(user_answer, params)
    @user_answer = user_answer
    @params = params
  end

  def set_user_answers
    user_answer.answers = user_question_answers
  end

  private

  def user_question_answers
    if params[:user] && params[:answer_keys]
      Hash[params[:answer_keys].zip params[:user][:answers]]
    else
      Hash.new
    end
  end
end
