class PdfCertificateGeneratorService
  attr_reader :user_course, :form_filler

  def initialize(course, user, user_course, form_filler)
    @user_course = user_course
    @form_filler = form_filler
  end

  def call
    user_course.certificate_path = form_filler.export()
  end
end
