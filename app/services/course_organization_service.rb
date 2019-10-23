class CourseOrganizationService
  def initialize(course, current_user, params)
    @course = course
    @current_user = current_user
    @params = params
  end

  def set_organization_id
    @course.organization_id = @current_user.organization_id
  end
end
