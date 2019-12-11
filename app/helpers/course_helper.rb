module CourseHelper
  def course_image(course)
    course.image_url ? image_tag(course.image_url(:thumb), class: "pp") : image_tag('course.svg')
  end

  def certificate_template(course)
    return unless course.attachment_pdf_file_name
    content_tag(:h2, "Certificate template: ", class: "title is-5", style: "float:left")+
    link_to(course.attachment_pdf.url) do
      content_tag(:span, content_tag(:i, " ", class: "fa fa-file-pdf-o")).html_safe
    end
  end

  def created_at(course)
    content_tag(:h3, "Created by: #{course.user.name} " + "#{time_ago_in_words(course.created_at)}" +
    " ago", class: "subtitle is-6").html_safe
  end

  def main_course_image(course)
    content_tag(:div, image_tag(course.image_url(:default)), class: "feature-image") if @course.image_url
  end

  def course_follow_form(course)
    return unless user_signed_in? && course.ready?

    unless course.access_state == "Private" && (course.organization_id != (current_user.participant_org_id || current_user.organization_id))
      render('follow_form')
    end
  end
end
