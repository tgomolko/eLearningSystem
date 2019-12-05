class BuildUserAnswer
  attr_reader :user_answer, :params

  def initialize(user_answer, params)
    @user_answer = user_answer
    @params = params
  end

  def call
    if params[:user] && params[:answer_keys]
      user_answer.answers = Hash[params[:answer_keys].zip params[:user][:answers]]
    else
      user_answer.answers = {}
    end
  end
end
