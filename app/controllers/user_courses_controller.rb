class UserCoursesController < ApplicationController
  before_action :set_course, :check_on_completed, only: [:complete]
  before_action :set_user_course, only: :result
  before_action :authenticate_user!
  
  def complete
    @user_course = UserCourse.new(user_course_params)

    user_course_complete_service = UserCourseCompleteService.new(@course, current_user, @user_course)
    user_course_complete_service.create_user_course
    if @user_course.save
      redirect_to @course, notice: t(:course_passed)
    else
      redirect_to @course, alert: t(:something_wrong)
    end
  end

  def result ; end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def user_course_params
    params.permit(:user_id, :course_id, :completed, :result, :answered_correctly)
  end

  def check_on_completed
    if current_user.user_courses.pluck(:course_id).include?(@course.id)
      redirect_to @course, alert: t(:course_already_completed)
    end
  end

  def set_user_course
    @course = Course.find(params[:id])
    @user_course = current_user.user_courses.where(course_id: @course.id).first
  end
end
