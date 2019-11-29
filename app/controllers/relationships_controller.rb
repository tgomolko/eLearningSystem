class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:followed_id])
    current_user.follow(@course)
    redirect_to course_page_path(@course, first_course_page), notice: t(:start_course)
  end

  def destroy
    @course = Relationship.find(params[:id]).followed
    if FinishCourseService.new(@course, current_user).call
      redirect_to @course, notice: t(:finish_course)
    else
      redirect_to @course, notice: t(:course_already_passed)
    end
  end

  private

  def first_course_page
    @first_course_page ||= @course.pages.sort_by { |page| page.created_at }
  end
end
