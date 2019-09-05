class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  
  def index
    @pages = Page.all.where(course_id: @course.id)
  end

  def new
    @page = @course.pages.build
  end

  def show
  end

  def create
    @page = @course.pages.build(page_params)
    if @page.save
      redirect_to course_path(@course), notice: 'Page was successfully created.'
    else
      render :news
    end
  end

  private

  def set_page
    @page = Page.find(params[:page_id])
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :course_id)
  end
end