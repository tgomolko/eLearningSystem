class QuestionService
  attr_reader :question, :params

  def initialize(question, params)
    @question = question
    @params = params
  end

  def set_answer
    question.answers = build_question_answer
  end

  private

  def build_question_answer
    if params[:questions] && params[:answers]
      Hash[params[:answers].zip params[:questions][:content]]
    else
      Hash.new
    end
  end
end
