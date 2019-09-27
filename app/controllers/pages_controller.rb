class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  before_action :authenticate_user!
  before_action :dont_show_completed_page, :dont_show_pages_not_following_course, only: :show
  
  def index
    @pages = Page.where(course_id: @course.id)
  end

  def new
    @page = @course.pages.build
  end

  def show
    @pages = @course.pages.order("created_at DESC")
    @last_page = @pages.max
  end

  def create
    @page = @course.pages.build(page_params)
    if @page.save
      redirect_to course_path(@course), notice: t(:page_created_successully)
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to edit_course_page_path(@course, @page), notice: t(:page_updated_successfully)
    else
      render :edit 
    end
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :course_id)
  end

  def dont_show_completed_page
    user_completed_pages_ids = current_user.user_pages.where(completed: true).pluck(:page_id)
    if user_completed_pages_ids.include?(@page.id)
      redirect_to @course, alert: t(:page_passed)
    end
  end

  def dont_show_pages_not_following_course
    unless current_user.following?(@course)
      redirect_to @course, alert: t(:start_follow_course)
    end
  end
end