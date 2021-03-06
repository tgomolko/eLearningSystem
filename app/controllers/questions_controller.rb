class QuestionsController < ApplicationController
  before_action :set_course, :set_page, only: :add
  before_action :authenticate_user!

  def add
    @question = @page.questions.build(question_params)
    BuildQuestionAnswer.new(@question, params).call

    if @question.save
      redirect_to course_page_path(@course, @page), notice: t(:question_added)
    else
      redirect_to course_page_path(@course, @page), alert: t(:something_wrong)
    end
  end

  private

  def question_params
    params.permit(:content, :question_type, :page_id, :answer, :answers, :questions)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_page
    @page = Page.find(params[:page_id])
  end
end
