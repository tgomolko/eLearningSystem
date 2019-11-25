class WelcomeController < ApplicationController
  def index
    @courses = Course.ready.last(5)
  end
end
