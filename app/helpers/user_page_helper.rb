module UserPageHelper
  def all_user_pages_completed?
    return unless user_signed_in?
    course_pages_ids = @course.pages.pluck(:id)
    return false if course_pages_ids.empty?
    course_pages_ids.size == current_user.user_pages.where(page_id: course_pages_ids).size
  end
end
