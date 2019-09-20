class QuestionService

  def initialize(question, params)
    @question = question
    @params = params
  end

  def set_answers_values
    @question.answers = checkbox_question_answers_hash
  end

  private 

  def checkbox_question_answers_hash
    if @params[:questions] && @params[:answers]
      answers = @params[:answers]
      checkbox_values = @params[:questions][:content]
      Hash[answers.zip checkbox_values]
    else
      Hash.new
    end
  end
end