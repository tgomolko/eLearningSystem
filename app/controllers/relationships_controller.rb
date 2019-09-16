class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:followed_id])
    current_user.follow(@course)
    #redirect_to course_page_path(@course, @course.pages.first), notice: "You started course"
    redirect_to @course, notice: "You started course"
  end

  def destroy
    @course = Relationship.find(params[:id]).followed
    current_user.unfollow(@course)
    redirect_to @course, alert: "You secessuflly unfollow course"
  end
end