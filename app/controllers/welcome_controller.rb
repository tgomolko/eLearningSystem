class WelcomeController < ApplicationController
  def index
    @courses = Course.last(5)
  end
end
