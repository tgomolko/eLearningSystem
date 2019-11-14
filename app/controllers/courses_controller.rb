class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all.includes(:user)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @pages = @course.pages
    @course_raiting = @course.course_raiting.average(:rate).to_i
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
    @course.organization_id = current_user.organization_id if params[:course][:access_state] == "Private"

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
end
