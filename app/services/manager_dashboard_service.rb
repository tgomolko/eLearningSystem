class ManagerDashboardService
  attr_reader :user, :params

  def initialize(user, params)
    @params = params
    @user = user
  end

  def organization_courses
    if sort_column_params?
      @organization_courses = user.organization.courses.paginate(page: params[:page], per_page: 10)
                                               .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @organization_courses = user.organization.courses.paginate(page: params[:page], per_page: 10)
                                               .where(["title LIKE ?", "%#{params[:q]}%"])
    end
    @organization_courses
  end

  def organization_users
    if sort_user_column_params?
      @organization_users = get_organization_users.paginate(page: params[:page], per_page: 10)
                                               .order(sort_user_column + " " + sort_direction)
    end
    if search_params?
      @organization_users = get_organization_users.paginate(page: params[:page], per_page: 10)
                                               .where(["name LIKE ?", "%#{params[:q]}%"])
    end
    @organization_users
  end

  def get_organization_users
    organization_users ||= Organization.find(user.organization_id).users
  end

  private

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_user_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column_params?
    sort_column && sort_direction
  end

  def sort_user_column_params?
    sort_user_column && sort_direction
  end

  def search_params?
    params[:q]
  end
end
