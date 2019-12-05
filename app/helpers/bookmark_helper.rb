module BookmarkHelper
  def bookmark_form(course)
    if course.favorite?(current_user)
      render "bookmarks/destroy_bookmark"
    else
      render "bookmarks/create_bookmark"
    end
  end
end
