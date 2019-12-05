class SearchCourse
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    if params[:q]
      @courses = paginate_found_courses(courses)
    else
      @courses = courses.paginate(page: params[:page], per_page: 8)
    end
  end

  private

  def courses
    couses ||= Course.ready.not_organizations
  end

  def paginate_found_courses(courses)
    courses.paginate(page: params[:page], per_page: 8).where(["title LIKE ?", "%#{params[:q]}%"])
  end
end
