class UserCoursesController < ApplicationController
  before_action :set_course
  before_action :completed?, only: :complete
  before_action :set_user_course, only: :result
  before_action :authenticate_user!

  include CourseHelper

  def complete
    @user_course = current_user.user_courses.build(user_course_params)
    UserCourseCompleteService.new(@course, current_user, @user_course, UserCourseResultCounterService.new(@course, current_user)).complete

    if @user_course.save
      redirect_to result_user_course_path(@course), notice: t(:course_passed)
    else
      redirect_to @course, alert: t(:something_wrong)
    end
  end

  def result
    @course_questions = Question.where(page_id: @course.pages.ids)
    @user_answers = current_user.user_answers.where(question_id: @course_questions.ids).order(:question_id)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def user_course_params
    params.permit(:user_id, :course_id, :completed, :result, :answered_correctly)
  end

  def completed?
    redirect_to @course, alert: t(:course_already_completed) if current_user.completed_course?(@course)
  end

  def set_user_course
    @user_course = current_user.user_courses.find_by(course_id: Course.find(params[:id]))
  end
end
