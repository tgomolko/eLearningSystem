class CourseOrganizationService
  attr_reader :course, :user, :params

  def initialize(course, user, params)
    @course = course
    @user = user
    @params = params
  end

  def set_organization_id
    course.organization_id = user.organization_id
  end
end
