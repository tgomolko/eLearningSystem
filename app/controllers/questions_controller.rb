class QuestionsController < ApplicationController
  before_action :set_course, :set_page, only: :add
  before_action :authenticate_user!
  
  def add
    @question = Question.new(question_params)
    @question.answers = checkbox_question_answers_hash
    respond_to do |format|
      if @question.save 
        format.html { redirect_to edit_course_page_path(@course, @page), notice: "Question was added" }
      else
       format.html { redirect_to edit_course_page_path(@course, @page), alert: "Something was wrong(" }
      end
    end
  end

  private 
  
  def checkbox_question_answers_hash
    if params[:questions] && params[:answers]
      answers = params[:answers]
      checkbox_values = params[:questions][:content]
      Hash[answers.zip checkbox_values]
    else
      Hash.new
    end
  end

  def question_params
    params.permit(:content, :question_type, :page_id, :answer, :answers)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_page
    @page = Page.find(params[:page_id])
  end
end
