module UserCourseHelper
  def certificate_url(path)
    path.split('/')[6..9].join('/').insert(0,"/")
  end
end
