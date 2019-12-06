class UserAnswersController < ApplicationController
  before_action :set_question, :set_course, :set_page, only: :create
  before_action :authenticate_user!

  def create
    @user_answer = current_user.user_answers.build(user_answer_params)
    BuildUserAnswer.new(@user_answer, params).call

    if @user_answer.save
      redirect_to course_page_path(@course, @page), notice: t(:answer_accepted)
    else
      redirect_to course_page_path(@course, @page), alert: t(:something_wrong)
    end
  end

  private

  def user_answer_params
    params.permit(:answer, :question_id, :course_id, :user_id, :answers)
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
