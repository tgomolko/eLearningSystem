module UserPageHelper
  
  def all_user_pages_completed?
    course_pages_ids = @course.pages.pluck(:id)
    return false if course_pages_ids.empty?
    current_user_pages_ids = current_user.user_pages.where(page_id: course_pages_ids)
    course_pages_ids.size == current_user_pages_ids.size
  end 
end
