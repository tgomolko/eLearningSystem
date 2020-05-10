module ApplicationHelper
  def navbar
    if user_signed_in?
      render "layouts/navbar"
    else
      render "layouts/welcome_navbar"
    end
  end
end
