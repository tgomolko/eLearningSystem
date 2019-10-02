class UserDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :service_dashboard, only: [:dashboard, :current_courses]
  helper_method :sort_column, :sort_direction

  
  def dashboard
    @uncompleted_courses = @user_dashboard_service.get_uncompleted_courses.last(5)
    @completed_courses = @user_dashboard_service.get_completed_courses
    @highest_rate_courses = @user_dashboard_service.get_highest_rate_courses
    @favorite_courses = @user_dashboard_service.get_favorite_courses
  end

  def current_courses
    if sort_column && sort_direction
      @current_courses = Course.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
      #@current_courses = @user_dashboard_service.get_uncompleted_courses.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    end
    if params[:search]
      @current_courses = Course.all.paginate(:page => params[:page], :per_page => 10).where(["title LIKE ?", "%#{params[:search]}%"])
      #@current_courses = @user_dashboard_service.get_uncompleted_courses.where(["title LIKE ?", "%#{params[:search]}%"])
    end
  end

  private 

  def service_dashboard
    @user_dashboard_service = UserDashboardService.new(current_user) 
  end

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
