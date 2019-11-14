class QuestionService
  attr_reader :question, :params

  def initialize(question, params)
    @question = question
    @params = params
  end

  def set_answers_values
    question.answers = checkbox_question_answers
  end

  private

  def checkbox_question_answers
    if params[:questions] && params[:answers]
     # answers = params[:answers]
     # checkbox_values = params[:questions][:content]
      #Hash[answers.zip checkbox_values]
      Hash[params[:answers].zip params[:questions][:content]]
    else
      Hash.new
    end
  end
end
