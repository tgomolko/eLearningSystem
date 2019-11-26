class PagePolicy < ApplicationPolicy
  def edit?
    @user.admin? || @user.id == @record.course.user.id
  end
end
