class BuildQuestionAnswer
  attr_reader :question, :params

  def initialize(question, params)
    @question = question
    @params = params
  end

  def call
    if params[:questions] && params[:answers]
      question.answers = params[:answers] = Hash[params[:answers].zip params[:questions][:content]]
    else
      question.answers = {}
    end
  end
end
