class TestPdfForm < FillablePdfForm
  def initialize(user, course)
    @user = user
    @course = course
    super(@course)
  end

  protected

  def fill_out
    fill :data, Date.today.strftime("%B %d, %Y")
    fill :title, @course.title
    fill :username, @user.username
  end
end
