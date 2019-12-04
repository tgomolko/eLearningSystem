class WelcomeController < ApplicationController
  def index
    @courses = Course.ready.first(5)
  end
end
