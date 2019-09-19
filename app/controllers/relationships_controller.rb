class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:followed_id])
    current_user.follow(@course)
    redirect_to course_page_path(@course, first_course_page), notice: "You started course"
  end

  def destroy
    @course = Relationship.find(params[:id]).followed
    current_user.unfollow(@course)
    redirect_to @course, alert: "You successfully unfollow course"
  end

  private 

  def first_course_page
    @course.pages.sort_by { |page| page.created_at }
  end
end