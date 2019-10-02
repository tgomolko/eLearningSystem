class UserDashboardService
  
  def initialize(user)
    @user = user   
  end

  def get_uncompleted_courses
    starting_courses_ids = @user.following.pluck(:id)
    completed_courses_ids = @user.user_courses.pluck(:course_id)
    uncompleted_courses_ids = starting_courses_ids - completed_courses_ids
    Course.where(id: uncompleted_courses_ids)
  end

  def get_completed_courses
    last_complection_ids = @user.user_courses.last(5).pluck(:course_id)
    Course.where(id: last_complection_ids)
  end

  def get_highest_rate_courses
    highest_rate_courses_ids = CourseRaiting.all.order(:rate).last(5).pluck(:course_id)
    Course.where(id: highest_rate_courses_ids)
  end
end
