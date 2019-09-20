class CourseRaitingsController < ApplicationController
  before_action :set_course, only: [:create]
  before_action :authenticate_user!

  def create
    @course_raiting = CourseRaiting.new(course_raiting_params)
    
    if @course_raiting.save
      redirect_to @course, notice: 'You rated course, thanks'
    else
       redirect_to @course, alert: "Something was wrong"
    end
  end

  private

  def course_raiting_params
    params.permit(:user_id, :course_id, :rate)
  end

  def set_course 
    @course = Course.find(params[:course_id])
  end
end
