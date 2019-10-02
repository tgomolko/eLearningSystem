module BookmarkHelper 
  def favorite?(course)
    current_user.bookmarks.pluck(:course_id).include?(course.id)
  end
end 
