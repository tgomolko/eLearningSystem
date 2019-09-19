class UserPagesController < ApplicationController
  before_action :set_page, only: :create
  before_action :set_course, only: [:create, :continue]
  before_action :authenticate_user!

  def create
    @user_page = UserPage.new(user_page_params)
    
    if all_question_answered?
      @user_page.completed = true
      if @user_page.save
        if next_page && @page != last_page
          redirect_to course_page_path(@course, next_page)
        else
          redirect_to @course, notice: "You passed all pages and answered on all questions"
        end
      else
        redirect_to course_page_path(@course, @page), alert: "Something was wrong"
      end
    else
      redirect_to course_page_path(@course, @page), alert: "You should answer all questions!!!"
    end
  end

  def continue
    if next_page
      redirect_to course_page_path(@course, next_page), notice: "Welcome back"
    else
      redirect_to @course, alert: "Course have already completed"
    end
  end

  private

  def user_page_params
    params.permit(:user_id, :page_id, :completed)
  end

  def set_course
   @course = Course.find(params[:course_id]) 
  end

  def set_page
    @page = Page.find(params[:page_id])
  end

  def next_page
    user_completed_pages_ids = current_user.user_pages.where(completed: true).pluck(:page_id)
    uncompleted_pages = @course.pages.where.not(id: user_completed_pages_ids).sort_by {|page| page.created_at }
    next_page = uncompleted_pages.first if uncompleted_pages.any?
  end

  def last_page
    @course.pages.order("created_at DESC").max
  end

  def all_question_answered?
    page_questions = @page.questions
    user_answers_count = current_user.user_answers.where(question_id: page_questions.pluck(:id)).size
    user_answers_count == page_questions.size
  end
end