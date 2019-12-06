class DeterminatePageService
  attr_reader :page, :current_user, :course

  def initialize(page, course, current_user)
    @page = page
    @course = course
    @current_user = current_user
  end

  def next_page?
    next_page && !last_page?
  end

  def next_page
    completed_pages_ids = current_user.user_pages.where(completed: true).pluck(:page_id)
    uncompleted_pages = course.pages.where.not(id: completed_pages_ids).sort_by {|page| page.created_at }
    next_page = uncompleted_pages.first if uncompleted_pages.any?
  end

  def last_page
    @last_page ||= course.pages.order("created_at DESC").max
  end

  def all_page_questions_answered?
    current_user.user_answers.where(question_id: page.questions.pluck(:id)).size == page.questions.size
  end

  private

  def last_page?
    page == last_page
  end
end
