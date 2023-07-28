class PlantsController < ApplicationController
  def index
    @plants = ["#{ENV['DATABASE_URL']}"]
  end
end
