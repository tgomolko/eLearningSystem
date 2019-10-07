class UserDashboardService

  def initialize(user, params)
    @user = user
    @params = params   
  end

  def get_uncompleted_courses
    starting_courses_ids = @user.following.pluck(:id)
    completed_courses_ids = @user.user_courses.pluck(:course_id)
    uncompleted_courses_ids = starting_courses_ids - completed_courses_ids
    Course.where(id: uncompleted_courses_ids)
  end

  def get_highest_rate_courses
    highest_rate_courses_ids = CourseRaiting.all.order(:rate).pluck(:course_id)
    Course.where(id: highest_rate_courses_ids)
  end

  def get_completed_courses
    last_complection_ids = @user.user_courses.pluck(:course_id)
    Course.where(id: last_complection_ids)
  end

  def get_favorite_courses
    favorite_courses_ids = @user.bookmarks.pluck(:course_id)
    Course.where(id: favorite_courses_ids)
  end

  def current_courses_search
    if sort_column_params?
      current_courses = get_uncompleted_courses.paginate(page: @params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    end
    if search_params?
      current_courses = get_uncompleted_courses.paginate(page: @params[:page], per_page: 10).where(["title LIKE ?", "%#{@params[:q]}%"])
    end
    current_courses
  end

  def favorites_courses_search
    if sort_column_params?
      favorite_courses = get_favorite_courses.paginate(page: @params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    end
    if search_params?
      favorite_courses = get_favorite_courses.paginate(page: @params[:page], per_page: 10).where(["title LIKE ?", "%#{@params[:q]}%"])
    end
    favorite_courses
  end

  def completed_courses_search
    if sort_column_params?
      completed_courses = get_completed_courses.paginate(page: @params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    end
    if search_params?
      completed_courses = get_completed_courses.paginate(page: @params[:page], per_page: 10).where(["title LIKE ?", "%#{@params[:q]}%"])
    end
    completed_courses
  end

  def recomendation_courses_search
    if sort_column_params?
      recomendations  = get_highest_rate_courses.paginate(page: @params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    end
    if search_params?
      recomendations = get_highest_rate_courses.paginate(page: @params[:page], per_page: 10).where(["title LIKE ?", "%#{@params[:q]}%"])
    end
    recomendations
  end

  private 

  def sort_column
    Course.column_names.include?(@params[:sort]) ? @params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(@params[:direction]) ? @params[:direction] : "asc"
  end

  def sort_column_params? 
    sort_column && sort_direction
  end

  def search_params? 
    @params[:q]
  end
end
