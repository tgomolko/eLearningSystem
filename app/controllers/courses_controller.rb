class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @pages = @course.pages
    @course_raiting = course_raiting
  end

  # GET /courses/new
  def new
    @course = current_user.courses.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.build(course_params)
    
    if @course.save
      redirect_to @course, notice: t(:course_created_successfully)
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    if @course.update(course_params)
      redirect_to @course, notice: t(:course_updated_successully)
    else
      render :edit 
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    redirect_to courses_url, notice: t(:course_destroyed_successully)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:title, :description, :aasm_state, :user_id, 
                                   :requirements, :access_state, :image, 
                                   :attachment_pdf)
  end

  def course_raiting
    if @course.course_raiting.any?
      (@course.course_raiting.pluck(:rate).reduce(:+) / @course.course_raiting.pluck(:rate).size.to_f).to_i
    else
      return 0
    end
  end
end
