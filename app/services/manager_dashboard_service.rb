class ManagerDashboardService

  def initialize(user, params)
    @params = params
    @user = user
  end

  def organization_courses_search
    if sort_column_params?
      @organization_courses = organization_courses.paginate(page: @params[:page], per_page: 10)
                                               .order(sort_column + " " + sort_direction)
    end
    if search_params?
      @organization_courses = organization_courses.paginate(page: @params[:page], per_page: 10)
                                               .where(["title LIKE ?", "%#{@params[:q]}%"])
    end
    @organization_courses
  end

  private

  def organization_courses
    @user.organization.courses
  end

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
