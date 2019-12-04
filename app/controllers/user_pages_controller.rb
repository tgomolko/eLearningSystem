class UserPagesController < ApplicationController
  before_action :set_page, only: :create
  before_action :set_course, only: [:create, :continue]
  before_action :authenticate_user!

  def create
    page_service = DeterminatePageService.new(@page, @course, current_user)

    @user_page = current_user.user_pages.build(user_page_params)

    if page_service.all_page_questions_answered? && @user_page.save
      if page_service.next_page?
        redirect_to course_page_path(@course, page_service.next_page)
      else
        redirect_to @course, notice: t(:passed_all_pages)
      end
    else
      redirect_to course_page_path(@course, @page), alert: t(:should_answer_all_questions)
    end
  end

  def continue
    page_service = DeterminatePageService.new(@page, @course, current_user)
    if page_service.next_page
      redirect_to course_page_path(@course, page_service.next_page), notice: t(:welcome_back)
    else
      redirect_to @course, alert: t(:course_already_completed)
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
end
