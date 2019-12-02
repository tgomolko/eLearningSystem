class BookmarksController < ApplicationController
  before_action :set_course, only: [:create, :destroy]
  before_action :set_bookmark, only: :destroy
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)

    redirect_to @course, notice: t(:added_bookmark) if @bookmark.save

    redirect_to @course, alert: t(:something_wrong)
  end

  def destroy
    @bookmark.destroy
    redirect_to @course, notice: t(:removed_from_bookmarks)
  end

  private

  def bookmark_params
    params.permit(:user_id, :course_id)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
