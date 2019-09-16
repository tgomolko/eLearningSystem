class UserAnswersController < ApplicationController
  before_action :set_question, :set_course, :set_page, only: :create
  before_action :authenticate_user!

  def create
    @user_answer = UserAnswer.new(user_answer_params)

    @user_answer.answers = user_question_answers_hash
    respond_to do |format|
      if @user_answer.save
        user_answer_service = UserAnswerService.new(@question)
        if user_answer_service.set_answered 
          format.html { redirect_to course_page_path(@course, @page), notice: "You answer was accepted" }
        end
      else
       format.html { redirect_to course_page_path(@course, @page), alert: "Something was wrong" } 
      end
    end
  end

  private 

  def user_answer_params
    params.permit(:answer, :question_id, :course_id, :user_id, :answers)
  end

  def user_question_answers_hash
    if params[:user] && params[:answer_keys]
      answers = params[:user][:answers]
      answers_keys = params[:answer_keys]
      Hash[answers_keys.zip answers]
    else
      Hash.new
    end
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_course
    @course = Course.find(params[:course_id])  
  end

  def set_page
    @page = Page.find(params[:page_id])    
  end
end
