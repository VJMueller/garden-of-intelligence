class PlantsController < ApplicationController
  def index
    @plants = [ENV['DATABASE_URL'], Rails.configuration.database_configuration["production"]["url"]]
  end
end
