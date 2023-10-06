class PlantsController < ApplicationController
  def index
    @plants = Plants.all
  end
end
