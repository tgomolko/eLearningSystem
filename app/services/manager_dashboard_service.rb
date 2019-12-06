class ManagerDashboardService < UserDashboardService
  attr_reader :user, :params

  def initialize(user, params)
    @params = params
    @user = user
  end

  def organization_courses_search
    @organization_courses = paginate_sort_courses(organization_courses) if sort_column_params?

    @organization_courses = paginate_found_courses(organization_courses) if search_params?

    @organization_courses
  end

  def organization_users_search
    @organization_users = paginate_sort_users(organization_users) if sort_user_column_params?

    @organization_users = paginate_found_users(organization_users) if search_params?

    @organization_users
  end

  def organization_users
    organization_users ||= Organization.find(user.organization_id).users
  end

  def organization_courses
    organization_courses ||= Course.where(organization_id: user.organization_id).or(Course.where(organization_id: user.participant_org_id))
  end

  private

  def sort_user_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_user_column_params?
    sort_user_column && sort_direction
  end

  def paginate_found_users(users)
    users.paginate(page: params[:page], per_page: 10).where(["name LIKE ?", "%#{params[:q]}%"])
  end

  def paginate_sort_users(users)
    users.paginate(page: params[:page], per_page: 10).order(sort_user_column + " " + sort_direction)
  end
end
