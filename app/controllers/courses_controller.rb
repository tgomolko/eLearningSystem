class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :destroy, :update, :ready, :draft]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_course_access, only: :edit

  def index
    @courses = Course.ready.includes(:user)
  end

  def show
    @pages = @course.pages
    @course_raiting = @course.course_raitings.average(:rate).to_i
  end

  def new
    @course = current_user.courses.build
  end

  def edit ; end

  def create
    @course = current_user.courses.build(build_course_params)

    if @course.save
      redirect_to @course, notice: t(:course_created_successfully)
    else
      render :new
    end
  end

  def update
    if @course.update(build_course_params)
      redirect_to @course, notice: t(:course_updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: t(:course_destroyed_successfully)
  end

  def ready
    @course.ready!
    redirect_to @course, notice: t(:course_status_changed_on_ready)
  end

  def draft
    @course.draft!
    redirect_to @course, notice: t(:course_status_changed_on_draft)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :aasm_state, :user_id,
                                   :requirements, :access_state, :image,
                                   :attachment_pdf)
  end

  def build_course_params
    BuildCourseParams.new(current_user, course_params).call
  end

  def ensure_course_access
    authorize @course
  rescue
    redirect_to root_path, alert: t(:access_disable)
  end
end
