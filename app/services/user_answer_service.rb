class UserAnswerService
  attr_reader :user_answer, :params

  def initialize(user_answer, params)
    @user_answer = user_answer
    @params = params
  end

  def set_user_answer
    user_answer.answers = build_user_answer
  end

  private

  def build_user_answer
    if params[:user] && params[:answer_keys]
      Hash[params[:answer_keys].zip params[:user][:answers]]
    else
      Hash.new
    end
  end
end
