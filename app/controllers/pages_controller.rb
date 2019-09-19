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
      redirect_to course_path(@course), notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to edit_course_page_path(@course, @page), notice: 'Page was successfully updated.'
    else
      ender :edit 
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

  def all_user_pages_completed?
    current_user.user_pages.size == @course.pages.size
  end

  def dont_show_completed_page
    user_completed_pages_ids = current_user.user_pages.where(completed: true).pluck(:page_id)
    if user_completed_pages_ids.include?(@page.id)
      redirect_to @course, alert: "You have already passed that page"
    end
  end

  def dont_show_pages_not_following_course
    unless current_user.following?(@course)
      redirect_to @course, alert: "Start follow course before"
    end
  end
end
