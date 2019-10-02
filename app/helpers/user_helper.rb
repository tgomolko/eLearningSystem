module UserHelper
  def get_raiting(user)
    user.user_courses.last(5)  
  end 
end
