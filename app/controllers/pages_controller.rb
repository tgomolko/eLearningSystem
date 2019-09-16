class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  before_action :authenticate_user!
  
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
end
