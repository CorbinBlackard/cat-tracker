class HomeController < ApplicationController
  def index
    @top_cats = Cat.order(times_spotted: :desc).limit(3)
  end
end
