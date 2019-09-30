class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:followed_id])
    current_user.follow(@course)
    if first_course_page.any?
      redirect_to course_page_path(@course, first_course_page), notice: t(:start_course)
    else
      redirect_to @course
    end
  end

  def destroy
    @course = Relationship.find(params[:id]).followed
    current_user.unfollow(@course)
    redirect_to @course, notice: t(:unfollow_course)
  end

  private

  def first_course_page
    @course.pages.sort_by { |page| page.created_at } 
  end
end
