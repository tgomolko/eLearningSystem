module UserDashboardHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def get_course(certificate)
    course_id = certificate.course_id
    Course.find(course_id)
  end
end
