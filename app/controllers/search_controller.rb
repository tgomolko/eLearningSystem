class SearchController < ApplicationController
  def searchf
    binding.pry

    @current_courses = params[:q].nil? ? [] : Course.search(params[:q])
  end
end
