class UserPageService
  def initialize(page, course, user)
    @page = page
    @course = course
    @user = current_user
  end

  def next_page
    user_completed_pages_ids = @user.user_pages.where(completed: true).pluck(:page_id)
    uncompleted_pages = @course.pages.where.not(id: user_completed_pages_ids).sort_by {|page| page.created_at }
    next_page = uncompleted_pages.first if uncompleted_pages.any?
  end

  def last_page
    @course.pages.order("created_at DESC").max
  end
end
