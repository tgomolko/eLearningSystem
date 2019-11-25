class UserDashboardService
  attr_reader :params, :user

  def initialize(user, params)
    @user = user
    @params = params
  end

  def build_dashboard_data(limit = 5, *data)
    data << get_uncompleted_courses.last(limit)
    data << get_completed_courses.last(limit)
    data << get_highest_rate_courses.last(limit)
    data << get_favorite_courses.last(limit)
    data << get_org_courses.last(limit)
    data << get_not_org_courses.last(limit)
  end

  def current_courses_search
    if sort_column_params?
      @current_courses = get_uncompleted_courses.paginate(page: params[:page], per_page: 10)
                                               .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @current_courses = get_uncompleted_courses.paginate(page: params[:page], per_page: 10)
                                               .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @current_courses
  end

  def favorites_courses_search
    if sort_column_params?
      @favorite_courses = get_favorite_courses.paginate(page: params[:page], per_page: 10)
                                             .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @favorite_courses = get_favorite_courses.paginate(page: params[:page], per_page: 10)
                                             .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @favorite_courses
  end

  def completed_courses_search
    if sort_column_params?
      @completed_courses = get_completed_courses.paginate(page: params[:page], per_page: 10)
                                               .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @completed_courses = get_completed_courses.paginate(page: params[:page], per_page: 10)
                                               .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @completed_courses
  end

  def recomendation_courses_search
    if sort_column_params?
      @recomendations  = get_highest_rate_courses.paginate(page: params[:page], per_page: 10)
                                                .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @recomendations = get_highest_rate_courses.paginate(page: params[:page], per_page: 10)
                                               .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @recomendations
  end

  def org_courses_search
    if sort_column_params?
      @org_courses  = get_org_courses.paginate(page: params[:page], per_page: 10)
                                    .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @org_courses = get_org_courses.paginate(page: params[:page], per_page: 10)
                                   .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @org_courses
  end

  def not_org_courses_search
    if sort_column_params?
      @not_org_courses  = get_not_org_courses.paginate(page: params[:page], per_page: 10)
                                            .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @not_org_courses = get_not_org_courses.paginate(page: params[:page], per_page: 10)
                                           .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @not_org_courses
  end

  def user_courses_search
    if sort_column_params?
      @user_courses = get_current_user_courses.paginate(page: params[:page], per_page: 10)
                                             .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @user_courses = get_current_user_courses.paginate(page: params[:page], per_page: 10)
                                             .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @user_courses
  end

  def user_certificates_search
    user_cettificates ||= get_user_certificates.paginate(page: params[:page], per_page: 10)
  end

  private

  def get_uncompleted_courses
    current_courses ||= user.following
  end

  def get_highest_rate_courses
    higest_rate_courses ||= Course.where(id: CourseRaiting.all.order(:rate).pluck(:course_id))
  end

  def get_completed_courses
    completed_courses ||= Course.where(id: @user.user_courses.pluck(:course_id))
  end

  def get_favorite_courses
    favorite_courses ||= Course.where(id: @user.bookmarks.pluck(:course_id))
  end

  def get_org_courses
    org_courses ||= Course.ready.where.not(organization_id: nil)
  end

  def get_not_org_courses
    not_org_courses ||= Course.ready.where(organization_id: nil)
  end

  def get_current_user_courses
    current_courses ||= @user.courses
  end

  def get_user_certificates
    user_cettificates ||= @user.user_courses.where.not(certificate_path: nil)
  end

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column_params?
    sort_column && sort_direction
  end

  def search_params?
    params[:q]
  end
end
