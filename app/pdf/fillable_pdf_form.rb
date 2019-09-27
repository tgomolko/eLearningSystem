class FillablePdfForm

  attr_writer :template_path
  attr_reader :attributes

  def initialize(course)
    @course = course
    fill_out
  end

  def export(output_file_path=nil)
    @output_path = output_file_path || "#{Rails.root}/public/attachment_pdf/certificates/#{SecureRandom.uuid}.pdf"
    pdftk.fill_form template_path, @output_path, attributes
    @output_path
  end

  def certificate_path
    @output_path
  end

  def get_field_names 
    pdftk.get_field_names template_path
  end

  def template_path
    if @course.attachment_pdf_file_name
      @template_path ||= "#{Rails.root}/public/attachment_pdf/#{@course.id}/#{@course.attachment_pdf_file_name}"
    else
      @template_path = default_template
    end
  end

  def default_template
    "#{Rails.root}/public/attachment_pdf/default_template/elearning_certificate.pdf"
  end

  protected

  def attributes
    @attributes ||= {}
  end

  def fill(key, value)
    attributes[key.to_s] = value
  end

  def pdftk
    @pdftk ||= PdfForms.new(ENV['PDFTK_PATH'] || '/usr/bin/pdftk')
  end

  def fill_out
    raise 'Must be overridden by child class'
  end
end
