class UserDashboardService
  attr_reader :params, :user

  def initialize(user, params)
    @user = user
    @params = params
  end

  def build_dashboard_data(limit = 5, *data)
    data << uncompleted_courses.last(limit)
    data << completed_courses.last(limit)
    data << highest_rate_courses.last(limit)
    data << favorite_courses.last(limit)
    data << org_courses.last(limit)
    data << not_org_courses.last(limit)
  end

  def current_courses_search
    @current_courses = paginate_sort_courses(uncompleted_courses) if sort_column_params?

    @current_courses = paginate_found_courses(uncompleted_courses) if search_params?

    @current_courses
  end

  def favorites_courses_search
    @favorite_courses = paginate_sort_courses(favorite_courses) if sort_column_params?

    @favorite_courses = paginate_found_courses(favorite_courses) if search_params?

    @favorite_courses
  end

  def completed_courses_search
    @completed_courses = paginate_sort_courses(completed_courses) if sort_column_params?

    @completed_courses = paginate_found_courses(completed_courses) if search_params?

    @completed_courses
  end

  def recomendation_courses_search
    @recomendations = paginate_sort_courses(highest_rate_courses) if sort_column_params?

    @recomendations = paginate_found_courses(highest_rate_courses) if search_params?

    @recomendations
  end

  def org_courses_search
    @org_courses = paginate_sort_courses(org_courses) if sort_column_params?

    @org_courses = paginate_found_courses(org_courses) if search_params?

    @org_courses
  end

  def not_org_courses_search
    @not_org_courses = paginate_sort_courses(not_org_courses) if sort_column_params?

    @not_org_courses = paginate_found_courses(not_org_courses) if search_params?

    @not_org_courses
  end

  def user_courses_search
    @user_courses = paginate_sort_courses(current_user_courses) if sort_column_params?

    @user_courses = paginate_found_courses(current_user_courses) if search_params?

    @user_courses
  end

  def user_certificates_search
    @user_certificates ||= user_certificates.paginate(page: params[:page], per_page: 10)
  end

  private

  def uncompleted_courses
    current_courses ||= user.following
  end

  def highest_rate_courses
    higest_rate_courses ||= Course.higest_rated
  end

  def completed_courses
    completed_courses ||= Course.where(id: @user.user_courses.pluck(:course_id))
  end

  def favorite_courses
    favorite_courses ||= Course.where(id: @user.bookmarks.pluck(:course_id))
  end

  def org_courses
    org_courses ||= Course.ready.organizations
  end

  def not_org_courses
    not_org_courses ||= Course.ready.not_organizations
  end

  def current_user_courses
    current_courses ||= @user.courses
  end

  def user_certificates
    user_certificates ||= @user.user_courses.where.not(certificate_path: nil)
  end

  def paginate_sort_courses(courses)
    courses.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
  end

  def paginate_found_courses(courses)
    courses.paginate(page: params[:page], per_page: 10).where(["title LIKE ?", "%#{params[:q]}%"])
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
